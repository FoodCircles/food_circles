class TimelineController < ApplicationController
  before_filter :authenticate_user!
  def index
    get_friends_purchases
    @weekly_total = current_user.payments.where("created_at > ?", Time.now - 1.week).collect{ |p| p.amount }.sum
    current_vouchers = Voucher.where("start_date <= ? and end_date >= ?", Time.now, Time.now)
    @total_vouchers = current_vouchers.collect{ |v| v.total }.sum
    @available_vouchers = current_vouchers.collect{ |v| v.available }.sum
    @payments = current_user.payments.order("created_at DESC").limit(3)
  end
  
  def get_friends_purchases
    begin
      require 'twitter'
      client = Twitter::Client.new(:oauth_token => current_user.twitter_token, :oauth_token_secret =>current_user.twitter_secret)
    
      user_ids = client.friends.map {|u| u.id}
      logger.debug "UIDS: #{user_ids}"
      user_ids.each do |uid|
        u = User.find_by_twitter_uid(uid.to_s)
        logger.debug "User: #{u}"
        unless u.nil?
          unless u.twitter_uid.nil?
            unless u == current_user
              current_user.friends << u.id
            end
          end
        end
      end
      current_user.friends = current_user.friends.uniq
      current_user.save
      
      @friends_payments = []
      current_user.friends.each do |u|
        @friends_payments << User.find(u).payments
      end
      @friends_payments.flatten.uniq
    rescue Twitter::Error::TooManyRequests => e
      logger.debug "HIT THE RATE LIMIT"
    end
  end
end
