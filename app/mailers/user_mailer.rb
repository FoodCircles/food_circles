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
    @url = 'http://www.foodcircles.net/app'
    mail(:to => email, :subject => "Do good. Eat well.")

  end
  def setup_email(user,r)

      mail = Mail.deliver do
      file = "redeem_guide"
      to user.email
      from 'FoodCircles <voucher@foodcircles.net>'
      subject "Got your coupon code for #{r.venue.name.capitalize.gsub(/\'/,"\\\'") }"
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<b>reply-to: support@foodcircles.net</b><br><p>Print this email or just show it off on a fancy electronic device.</p>
              <br>confirmation code: <b>[5-digit code]</b><br>
              good for: <b>[deal]</b><br>
              only at: <b>[venue]</b><br>
              with a minimum of: <b>[min. groupsize] diners </b><br>
              <b>expiring: (2/28/13) <-today's date + 7 days </b><br>
              <b>3 steps to redeem:</b><p><br><br>

              <b>1)</b> Show server this message before you order.  They should jot your code down and confirm.<br>
              <b>2)</b> Order regular food or drink for each person in party.<br>
              <b>3)</b> " "Your Buy One, Feed One"  "item(s) will be taken off your final receipt.</p> <br>Enjoy!<br>
              Contact support at <b>support@foodcircles.net</b> if you have any concerns or questions whatsoever.<br>
              <h3><u>FOR SERVERS:</u></h3><br><br>"



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
