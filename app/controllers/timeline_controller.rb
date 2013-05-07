class TimelineController < ApplicationController
  def index
    @weekly_total = Reservation.where("created_at > ?", Time.now - 1.week)
  end
end
