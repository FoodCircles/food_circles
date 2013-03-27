class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :email_server
  before_filter :prepare_for_mobile

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
    sql = "select date_trunc('month', current_date - INTERVAL '#{months_before} month') as start_date, date_trunc('month', current_date - INTERVAL '#{months_before} month')+'1month'::interval-'1day'::interval as end_date;"
    @previous_month_dates = Reservation.find_by_sql(sql)
    start_date = @previous_month_dates[0][:start_date]
    end_date = @previous_month_dates[0][:end_date]
    @s = start_date
    @e = end_date

    #@reserve_venues have all data remember it.
    @reserve_venues = Reservation.where("created_at >= :start_date AND created_at <= :end_date AND venue_id = :vid",
                                        {:start_date => start_date, :end_date => end_date,:vid => params[:vid].to_i })
    find_venue = "select name,id,address,multiplier from venues where id IN(#{params[:vid].to_i})"
    @venue_names = Venue.find_by_sql(find_venue)

    gr_kids ="select count(charity_id) as gr_kids from reservations where charity_id ='1' AND venue_id = #{params[:vid].to_i} AND created_at >= '#{@s}' AND created_at <= '#{@e}'"
    world_kids ="select count(charity_id) as world_kids from reservations where charity_id ='2' AND venue_id = #{params[:vid].to_i} AND created_at >= '#{@s}' AND created_at <= '#{@e}' "

    @gr_kids = Reservation.find_by_sql(gr_kids)
    @world_kids=Reservation.find_by_sql(world_kids)



  end



end

