class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :email_server
  before_filter :prepare_for_mobile
  before_filter :detect_email_omniauth
  before_filter :check_subdomain


  ACCOUNT_SID = "AC085df9dc6444a3588933ae0ddd9d95e7"
  ACCOUNT_TOKEN = "95cc7f360064ab606017dad6d2eb38a5"

  BASE_URL = "http://joinfoodcircles.org"

  CALLER_ID = "14422223663"
  #tkxel_dev: Following method detects incoming request from an email server and redirect users
  #To respective app store to downloaf foodcircles app.

  def check_subdomain
    unless ['', 'www', 'staging', 'testing'].include?(request.subdomain)
      sub_charity = Charity.active.find_by_subdomain(request.subdomain)
      unless sub_charity
        redirect_to BASE_URL
      end
    end
  end

  def email_server
    unless request.env['HTTP_USER_AGENT'].nil?
      user_agent =  request.env['HTTP_USER_AGENT'].downcase
      request.user_agent =~ /Mobile|webOS/

      if(params['app'].present?)

        if(user_agent.include?"android")

          redirect_to  "https://play.google.com/store/apps/details?id=co.foodcircles"

        elsif (user_agent.include?"iphone")
          redirect_to "http://itunes.apple.com/us/app/foodcircles/id526107767"
        elsif !((request.user_agent =~ /Mobile/).nil?)
          redirect_to root_path
        else

          redirect_to  "http://www.foodcircles.net/app"

        end
      else

        prepare_for_mobile

      end
    end

  end

  def genCoupon
    s = [('A'..'Z'),('0'..'9')].map{|i| i.to_a}.flatten
    (0..4).map{s[rand(s.length)]}.join.downcase
  end

  def makeCall(v,r,minutes)
    return if r.called

    r.called = true
    r.save

    data = {
      :from => CALLER_ID,
      :to => v.phone,
      :url => BASE_URL + "/notification?r=#{r.id}&m=#{minutes}"
    }

    begin
      client = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
      client.account.calls.create data
    rescue StandardError => bang
      redirect_to :action => '.', 'msg' => "Error #{bang}"
      return
    end
  end

  def notification
    @r = Reservation.find(params[:r])
    @minutes = params[:minutes]
    @r.called = true
    @r.save
    render :action => "notification.xml.builder", :layout => false
  end

  def sendText(p, b)
    @twilio = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    @account = @twilio.account
    @account.sms.messages.create(:from => '+14422223663', :to => p, :body => b)
    #@twilio.account.sms.messages.delay.create(:from => "+14422223663", :to => p, :body => b)
  end

  def download
    user_agent =  request.env['HTTP_USER_AGENT'].downcase
    if user_agent.index('android')
      redirect_to "https://play.google.com/store/apps/details?id=co.foodcircles"
      return
    elsif user_agent.index('iphone')
      redirect_to "http://itunes.apple.com/us/app/foodcircles/id526107767"
      return
    end
  end

  def after_sign_in_path_for(resource_or_scope)
    request.env['omniauth.origin'] || stored_location_for(resource_or_scope) || root_path
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  def enqueue_mix_panel_event(event_name, event_params = {})
    queued_mixpanel_events.push OpenStruct.new(name: event_name, params: event_params)
  end

  def queued_mixpanel_events
    # Uses a session so it persists between redirects
    session[:queued_mixpanel_events] ||= []
  end

  private

  def mobile_device?
    puts request.user_agent
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def android_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Android/
    end
  end

  def ios_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /iPod|iPhone|iPad/
    end
  end

  def prepare_for_mobile
    return if params[:callback]
    session[:mobile_param] = params[:mobile] if params[:mobile]
    if mobile_device? and request.fullpath == '/'
      if android_device?
        # Not needed anymore, we now have a Android bar plugin
      elsif ios_device?
        # Not needed anymore, we now have native iOS advertising
      else
        #request.format = :mobile  <-- Have no real usecase for non-iOS, non-Android users besides the site -->
      end
    end
  end

  def mobile_app(p)
    b = "Download the Apple app: https://itunes.apple.com/us/app/foodcircles/id526107767?mt=8 Or, download the Android app: https://play.google.com/store/apps/details?id=co.foodcircles"
    sendText(p, b)
  end

  # def valid_email?(email)
  #  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #  email.present? && (email =~ VALID_EMAIL_REGEX)
  # end

  def weekly_meal_goal
    @_weekly_meal_goal ||= Calculations::Weekly.meal_goal
  end

  def total_week_payments
    @_total_week_payments ||= Payment.total_week_payments
  end

  def total_meals_adjustment
    -1151
  end

  def total_meals
    @_total_meals ||= Payment.sum("amount").floor + Reservation.sum("amount").floor + total_meals_adjustment
  end

  def total_payments
    @_total_payments ||= Payment.count
  end

  def weekly_progress
    @_weekly_progress ||= Calculations::Weekly.weekly_progress
  end

  def percent
    @_percent ||= Calculations::Weekly.percent
  end

  def detect_email_omniauth
    if !current_user.nil?
      if current_user.email.blank? and controller_name != "omniauth_ask_for_email"
        redirect_to omniauth_email_path

      end
    end
  end

  def custom_body_classes
    @custom_body_classes ||= []
  end

  def stripe_customer?
    user_signed_in? && current_user.stripe_customer_token.present?
  end

  def current_user_credit_card_data
    @current_user_credit_card_data ||= Stripe::Customer.retrieve(current_user.stripe_customer_token).active_card
  end

  helper_method :weekly_meal_goal, :total_week_payments, :total_payments, :weekly_progress, :percent, :custom_body_classes
  helper_method :stripe_customer?, :current_user_credit_card_data, :total_meals
  helper_method :enqueue_mix_panel_event, :queued_mixpanel_events
end
