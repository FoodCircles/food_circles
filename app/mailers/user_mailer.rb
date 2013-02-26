class UserMailer < ActionMailer::Base
  default from:"\"FoodCircles\" <voucher@foodcircles.net>"
  require 'mail'
  Mail.defaults do
    delivery_method :smtp, { :address   => "smtp.sendgrid.net",
                             :port      => 587,
                             :domain    => "foodcircles.net",
                             :user_name => "Haseeb Khan",
                             :password  => "password1",
                             :authentication => 'plain',
                             :enable_starttls_auto => true }
  end
  def food_mail(email)
    @url = 'http://foodcircles.net/?app=mobile_email'
    mail(:to => email,:reply_to => 'jonathan@foodcircles.net', :subject => "Do good. Eat well.")
  end
  def setup_email(user,r)

     user_reservation = Reservation.find_by_offer_id(r.offer_id.to_i)
     deal = Offer.find(user_reservation.offer_id)
      mail = Mail.deliver do
     to user.email
      from 'FoodCircles <hey@foodcircles.net>'
      subject "Got your coupon code for #{r.venue.name.capitalize.gsub(/\'/,"\\\'") }"
      reply_to 'support@foodcircles.net'
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<table width = '550px'><tr><td style = font-size:12pt; font-family:Arial><p style= text-align: justify;>Print this email or just show it off on a fancy electronic device.</p>
              <p style= text-align: justify>
              <b>confirmation code:</b> #{r.coupon}<br>
              <b>good for:</b> #{deal.name}<br>
              <b>only at:</b> #{r.venue.name}<br>
              <b>with a minimum of:</b> #{user_reservation.num_diners} diners<br>
              <b>expiring:</b> #{7.days.from_now.to_date}</p><br>
              <b>3 steps to redeem:</b>
              <p>
              <b>1)</b> Show server this message before you order.  They should jot your code down and confirm.<br>
              <b>2)</b> Order regular food or drink for each person in party.<br>
              <b>3)</b> Your \"Buy One, Feed One\"  item(s) will be taken off your final receipt.
              </p><br><br>
              Enjoy!<br><br>
              Contact support at <b>support@foodcircles.net</b> if you have any concerns or questions whatsoever.<br><br><br>
              <h3><u>FOR SERVERS:</u></h3>
              <p style= text-align: justify;><b>Write down the confirmation code on the table's receipt or your POS system</b>.  Place a  \"Buy One, Feed One\"  placard on the guest's table, and mark a tally on your chalkboard (if available).  Call us at 312 945 8627 with any questions!</p></td></tr></table>"
        end
    end
  end


  def voucher(user, r)
    @user = user
    @r = r
    mail(:to => @user.email, :subject => "Your voucher for #{r.venue.name.capitalize}")
  end

  def signupsuccess(user)
  #@user = user
  #mail_for_signupsuccess(:to => user.email, :subject => "An email for test")
  #mail(:to => 'jinnahrae@gmail.com', :subject => "An email for test")
  end

  def create_voucher(user,r)
    @user = user
    @r = r
    setup_email(@user,@r)
    #mail_for_voucher(:to => @user.email,
    #  :subject => "Your voucher for #{r.venue.name.capitalize.gsub(/\'/,"\\\'") }",
    #  :reservation => r )
    #mail(:to => 'jinnahrae@gmail.com', :subject => "An email for test")
  end

  def remind_mail(to)
    mail_for_remind(:to=>to, :subject=>"Newsletter mail")
  end

end
