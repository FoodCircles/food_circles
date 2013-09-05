module Calculations
  class Weekly
    attr_reader :venues, :current_weekly_payments, :offers

    def self.meal_goal
      new.meal_goal
    end

    def self.weekly_progress
      new.weekly_progress
    end

    def self.percent
      new.percent
    end

    def initialize
      @venues = Venue.all
      @current_weekly_payments = Payment.total_week_payments
      @offers = Offer.all
    end

    def meal_goal
      weekly_meal_goal = (3.0/4.0) * offers_count
      rounddown(weekly_meal_goal.floor)
    end

    def weekly_progress
      {current_progress: progress.floor, adjusted_total: meal_goal}
    end

    def percent
      week_goal = meal_goal
      week_goal == 0 ? 0 : weekly_progress[:current_progress].to_f / week_goal * 100
    end

    private
    def rounddown(value, nearest=5)
      value - (value % nearest)
    end

    def offers_count
      venues.sum{|v| v.vouchers_total.to_i}
    end

    def progress
      current_weekly_payments.sum("amount")
    end
  end
end
