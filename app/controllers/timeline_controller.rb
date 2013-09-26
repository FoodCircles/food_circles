class TimelineController < ApplicationController
  include PaymentCommons

  before_filter :authenticate_user!
  def index
    enqueue_mix_panel_event "Visits Timeline"

    get_friends_purchases
    load_payments
    load_reservations
    load_weekly_total

    custom_body_classes << "no-activity" if @payments.empty? && @reservations.empty?

    current_vouchers = Voucher.where("start_date <= ? and end_date >= ?", Time.now, Time.now)
    @total_vouchers = current_vouchers.collect{ |v| v.total }.sum
    @available_vouchers = current_vouchers.collect{ |v| v.available }.sum
  end
end
