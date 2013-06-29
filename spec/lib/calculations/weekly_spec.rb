require "spec_helper"

describe Calculations::Weekly do
  before(:each) do 
    build_user_data
    Database::Factory.create_records(Venue, "venues.yml")
  end

  it "returns a new instance of Weekly" do
    stub_object = Calculations::Weekly.new
    Calculations::Weekly.stub(new: stub_object)
    weekly_calculations = Calculations::Weekly.new
    weekly_calculations.should == stub_object
  end

  describe "#goal" do
    it "calculates the weekly meal goal" do
      weekly_calculations = Calculations::Weekly.new
      weekly_calculations.meal_goal.should == 82
    end
  end

  describe "#weekly_progress" do
    it "calculates the progress made within a week" do
      expected_hash = {:current_progress=>0, :adjusted_total=>11.25}

      weekly_calculations = Calculations::Weekly.new
      weekly_calculations.weekly_progress.should == expected_hash
    end
  end

  describe "#percent" do
    it "calculates the current progress as percent" do
      weekly_calculations = Calculations::Weekly.new
      weekly_calculations.percent.should == 0
    end
  end
end
