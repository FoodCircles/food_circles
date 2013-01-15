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

  def setup_email(user,r)
    mail = Mail.deliver do
      file = "redeem_guide"
      to user.email
      from 'FoodCircles <voucher@foodcircles.net>'
      subject "Your voucher for #{r.venue.name.capitalize.gsub(/\'/,"\\\'") }"
      text_part do
        body 'Hello world in text'
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body `cat #{file}`
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
