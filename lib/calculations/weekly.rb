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
      weekly_meal_goal.floor
    end

    def weekly_progress
      current_progress = progress / 100

      vouchers = total_vouchers.round
      adjusted_total = 3 * total_vouchers / 4
      {current_progress: current_progress, adjusted_total: adjusted_total}
    end

    def percent
      week_goal = meal_goal
      week_goal == 0 ? 0 : weekly_progress[:current_progress].to_f / week_goal * 100
    end

    private

    def offers_count
      offers = 0
      venues.each do |restaurant|
        offers += restaurant.vouchers_total unless restaurant.vouchers_total.nil?
      end
      offers
    end

    def progress
      progress = 0
      current_weekly_payments.all.each do |payment|
        progress += payment.amount
      end

      progress
    end

    def total_vouchers
      total_vouchers = 0
      offers.each do |offer|
        total_vouchers += offer.price.to_i * offer.total.to_i
      end
      total_vouchers
    end
  end
end
