class TimelineController < ApplicationController
  before_filter :authenticate_user!
  def index
    @weekly_total = Payment.where("created_at > ?", Time.now - 1.week).collect{ |p| p.amount }.sum
    current_vouchers = Voucher.where("start_date <= ? and end_date >= ?", Time.now, Time.now)
    @total_vouchers = current_vouchers.collect{ |v| v.total }.sum
    @available_vouchers = current_vouchers.collect{ |v| v.available }.sum
    @payments = Payment.order("created_at DESC").limit(3)
  end
end
