require "spec_helper"

describe Calculate::WeeklyMeal do
  before(:each) { build_user_data }

  it "returns a new instance of WeeklyMeal" do
    stub_object = Calculate::WeeklyMeal.new
    Calculate::WeeklyMeal.stub(new: stub_object)
    weekly_meal = Calculate::WeeklyMeal.new
    weekly_meal.should == stub_object
  end

  describe "#goal" do
    it "calculates the weekly meal goal" do
      weekly_meal = Calculate::WeeklyMeal.new
      weekly_meal.goal.should == 7
    end
  end
end