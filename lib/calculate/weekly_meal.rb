module Calculate
  class WeeklyMeal
    attr_reader :restaurants

    def self.goal
      new.goal
    end

    def initialize
      @restaurants = Venue.all
    end

    def goal
      offers = 0
      restaurants.each do |restaurant|
        offers += restaurant.vouchers_total unless restaurant.vouchers_total.nil?
      end

      weekly_meal_goal = (3.0/4.0) * offers
      weekly_meal_goal.floor
    end
  end
end