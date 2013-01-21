class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :prepare_for_mobile

  ACCOUNT_SID = "AC085df9dc6444a3588933ae0ddd9d95e7"
  ACCOUNT_TOKEN = "95cc7f360064ab606017dad6d2eb38a5"

  BASE_URL = "http://foodcircles.net"

  CALLER_ID = "14422223663"

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




end

