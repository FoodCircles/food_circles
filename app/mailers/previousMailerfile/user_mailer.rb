class UserMailer < ActionMailer::Base
  default from: "\"FoodCircles\" <voucher@foodcircles.net>"
  
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
    mail_for_voucher(:to => @user.email, 
      :subject => "Your voucher for #{r.venue.name.capitalize.gsub(/\'/,"\\\'") }",
      :reservation => r )
    #mail(:to => 'jinnahrae@gmail.com', :subject => "An email for test")
  end

  def remind_mail(to)
    mail_for_remind(:to=>to, :subject=>"Newsletter mail")
  end

end
