class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :email_server
  before_filter :prepare_for_mobile
  before_filter :detect_email_omniauth

  ACCOUNT_SID = "AC085df9dc6444a3588933ae0ddd9d95e7"
  ACCOUNT_TOKEN = "95cc7f360064ab606017dad6d2eb38a5"

  BASE_URL = "http://foodcircles.net"

  CALLER_ID = "14422223663"
  #tkxel_dev: Following method detects incoming request from an email server and redirect users
  #To respective app store to downloaf foodcircles app.

  def email_server

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
    if mobile_device?
      if android_device?
        request.format = :android
      elsif ios_device?
        request.format = :iphone
      else
        request.format = :mobile
      end
    end
  end

  #tkxel_dev: Following method collect data for monthly invoice reports in PDF formats.
  def generate_invoice
    @vid = params[:vid].to_i
    months_before = params[:months_before].to_i
    @months_before = months_before
    calculations = Calculations::Monthly.new(@vid, months_before)

    @s = calculations.start_date
    @e = calculations.end_date

    #@reserve_venues have all data remember it.
    @reserve_venues = calculations.reserve_venues
    @venue_names = calculations.venue_names

    @gr_kids = calculations.gr_kids
    @world_kids = calculations.world_kids
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
  helper_method :weekly_meal_goal, :total_week_payments, :total_payments, :weekly_progress, :percent
end

