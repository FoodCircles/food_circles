module PaymentCommons
  def get_friends_purchases
    @friends_payments = []
    return unless current_user.twitter_token && current_user.twitter_secret
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

      current_user.friends.each do |u|
        @friends_payments << User.find(u).payments
      end
      @friends_payments.flatten.uniq
    rescue Twitter::Error::TooManyRequests => e
      logger.debug "HIT THE RATE LIMIT"
    rescue Twitter::Error::Forbidden => e
      logger.debug "WRONG TWITTER CREDS"
    end
  end

  def load_reservations
    @reservations = current_user.reservations.order("created_at DESC")
  end

  def load_payments
    @payments = current_user.payments.order("created_at DESC").joins(:offer).uniq
  end

  def load_weekly_total
    @weekly_total = current_user.payments.where("created_at > ?", Time.now - 1.week).collect{ |p| p.amount }.sum
  end
end
