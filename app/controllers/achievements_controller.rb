class AchievementsController < ApplicationController
  layout 'achievements'


  before_filter :authenticate_user!
  before_filter :only_admins

  def only_admins
    redirect_to '/' unless warden.user.is_admin?
  end

  def index
  end

  def best_donors
    calculations = Calculations::Achievements.new
    best_donors = calculations.best_donors
    @donors_table = []

    best_donors.each do |bd|
      bd.payments.each do |pay|
        if pay.offer
          if pay.amount > pay.offer.price && pay.created_at > calculations.dt_min
            reg = {}

            reg[:email] = bd.email
            reg[:offer] = pay.offer.name
            reg[:our_price] = pay.offer.price.to_i
            reg[:amount_paid] = pay.amount.to_i
            reg[:date] = pay.created_at
            if pay.charity_id == nil
              reg[:charity] = "Null"
            else
              reg[:charity] = pay.charity.name
            end
            reg[:code] = pay.code
            reg[:state] = pay.state

            @donors_table.push(reg)
          end
        end
      end
    end

    @donors_table.sort! { |a, b| a[:date] <=> b[:date] }.reverse!
  end

end
