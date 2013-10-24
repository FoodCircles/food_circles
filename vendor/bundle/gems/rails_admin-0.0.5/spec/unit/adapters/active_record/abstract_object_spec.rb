require 'spec_helper'

describe "AbstractObject", :active_record => true do
  describe "proxy" do
    let(:object) { mock("object") }
    let(:abstract_object) { RailsAdmin::Adapters::ActiveRecord::AbstractObject.new(object) }

    it "should act like a proxy" do
      object.should_receive(:method_call)
      abstract_object.method_call
    end
  end

  describe "create" do
    let(:player) { Player.new }
    let(:object) { RailsAdmin::Adapters::ActiveRecord::AbstractObject.new player }
    let(:name) { "Stefan Kiszonka" }
    let(:number) { 87 }
    let(:position) { "Fifth baseman" }
    let(:suspended) { true }

    describe "a record without associations" do
      before do
        object.set_attributes({ :name => name, :number => number, :position => position, :suspended => suspended, :team_id => nil })
      end

      it "should create a Player with given attributes" do
        object.save.should be_true

        player.reload
        player.name.should == name
        player.number.should == number
        player.position.should == position
        player.suspended.should == false # protected
        player.draft.should == nil
        player.team.should == nil
      end
    end

    describe "a record with protected attributes and has_one association" do
      let(:draft) { FactoryGirl.create(:draft) }
      let(:number) { draft.player.number + 1 } # to avoid collision

      before do
        object.set_attributes({ :name => name, :number => number, :position => position, :suspended => suspended, :team_id => nil, :draft_id => draft.id })
      end

      it "should create a Player with given attributes" do
        object.save.should be_true

        player.reload
        player.name.should == name
        player.number.should == number
        player.position.should == position
        player.suspended.should == false # protected
        player.draft.should == draft.reload
        player.team.should == nil
      end
    end

    describe "a record with has_many associations" do
      let(:league) { League.new }
      let(:object) { RailsAdmin::Adapters::ActiveRecord::AbstractObject.new league }
      let(:name) { "Awesome League" }
      let(:teams) { [FactoryGirl.create(:team)] }
      let(:divisions) { [Division.create!(:name => 'div 1', :league => League.create!(:name => 'north')), Division.create!(:name => 'div 2', :league => League.create!(:name => 'south'))] }

      before do
        object.set_attributes({ :name  => name, :division_ids => divisions.map(&:id) })
      end

      it "should create a League with given attributes and associations" do
        object.save.should be_true
        league.reload
        league.name.should == name
        league.divisions.should == divisions
      end
    end
  end

  describe "update" do
    describe "a record with protected attributes and has_one association" do
      let(:name) { "Stefan Koza" }
      let(:suspended) { true }
      let(:player) { FactoryGirl.create(:player, :suspended => true, :name => name, :draft => FactoryGirl.create(:draft)) }
      let(:object) { RailsAdmin::Adapters::ActiveRecord::AbstractObject.new player }
      let(:new_team) { FactoryGirl.create(:team) }
      let(:new_suspended) { false }
      let(:new_draft) { nil }
      let(:new_number) { player.number + 29 }

      before do
        object.set_attributes({ :number => new_number, :team_id => new_team.id, :suspended => new_suspended, :draft_id => new_draft })
        object.save
      end

      it "should update a record and associations" do
        object.reload
        object.number.should == new_number
        object.name.should == name
        object.draft.should == nil
        object.suspended.should == true # protected
        object.team.should == new_team
      end
    end
  end

  describe "destroy" do
    let(:player) { FactoryGirl.create(:player) }
    let(:object) { RailsAdmin::Adapters::ActiveRecord::AbstractObject.new player }

    before do
      object.destroy
    end

    it "should delete the record" do
      Player.exists?(player.id).should == false
    end
  end

  describe "object_label_method" do
    it 'should be configurable' do
      RailsAdmin.config League do
        object_label_method { :custom_name }
      end

      @league = FactoryGirl.create :league

      RailsAdmin.config('League').with(:object => @league).object_label.should == "League '#{@league.name}'"
    end
  end
end
