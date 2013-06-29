require "spec_helper"

describe Database::Factory do
  let(:stub_object) { Database::Factory.new(User, "users.yml") }

  describe "#new" do
    it "instantiates a new Factory object" do
      Database::Factory.stub(new: stub_object)
      user_factory = Database::Factory.new
      user_factory.should == stub_object
    end
  end

  describe "#create" do
    let(:user_factory) { Database::Factory.new(User, "users.yml") }

    it "creates records for passed in class as a symbol" do
      User.should_receive(:create).at_least(1).times
      user_factory.create_records
    end
  end

  describe ".create_records" do
    it "creates records at the class level" do
      User.should_receive(:create).at_least(1).times
      Database::Factory.create_records(User, "users.yml")
    end
  end
end
