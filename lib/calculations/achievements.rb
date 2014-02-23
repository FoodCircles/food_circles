module Calculations
  class Achievements

    def dt_min
      Date.new(2013, 11, 4)
    end
    
    def best_donors
      User.joins(payments: :offer).where("payments.amount > offers.price and payments.created_at > ?", self.dt_min).uniq.all
    end
  end
end
