class TimelineController < ApplicationController
  def index
    @weekly_total = Reservation.where("created_at > ?", Time.now - 1.week)
    @payments = Payment.order(:created_at).limit(3)
  end
end
