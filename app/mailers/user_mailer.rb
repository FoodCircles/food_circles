class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  ADMIN_EMAIL = 'jonathan@foodcircles.net'
  SUPPORT_EMAIL = 'support@foodcircles.net'

  #tkxel_dev: SendGrid credentilas for email.
  default from: "\"FoodCircles\" <voucher@foodcircles.net>"
  require 'mail'
  Mail.defaults do
    delivery_method :smtp, {:address => "smtp.mandrillapp.com",
                            :port => 587,
                            :domain => "foodcircles.net",
                            :user_name => "jonathan@foodcircles.net",
                            :password => "uQjfYEZZxNUpGq0oeoVjmw",
                            :authentication => 'plain',
                            :enable_starttls_auto => true}
  end
  #tkxel_dev: Send email upon voucher creation
  def food_mail(email)

    @url = 'http://foodcircles.net/?app=mobile_email'
    mail(:to => email, :reply_to => 'jonathan@foodcircles.net', :subject => "Your appetite is powerful.")
  end

  #tkxel_dev: Email Content creation is handled in the following method.
  def setup_email(user, payment)
    mail = Mail.deliver do
      to user.email
      from 'FoodCircles <hey@foodcircles.net>'
      subject "Got your Voucher for #{payment.offer.venue.name}"
      reply_to 'used@inbound.foodcircles.net'
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<table width = '550px'><tr><td style = font-size:12pt; font-family:Arial><p style= text-align: justify;>Print this email or just show it off on a fancy electronic device.</p>
              <p style= text-align: justify>
              <b>confirmation code:</b> #{payment.code}<br>
              <b>good for:</b> #{payment.offer.name}<br>
              <b>only at:</b> #{payment.offer.venue.name}<br>
              <b>with a minimum of:</b> #{payment.offer.min_diners} diners<br>
              <b>expiring:</b> #{30.days.from_now.to_date}</p><br>
              <b>3 steps to redeem:</b>
              <p>
              <b>1)</b> Show server this message before you order.  They should jot your code down and confirm.<br>
              <b>2)</b> Order regular food or drink for each person in party.<br>
              <b>3)</b> Mark Voucher used by following this link! <a href=\"http://staging.foodcircles.net/payment/used?code=#{payment.code}&source=email\">Mark Voucher Used</a></br>
              </p><br><br>
              Enjoy!<br><br>
              Contact support at <b>support@foodcircles.net</b> if you have any concerns or questions whatsoever.<br><br><br>
              <h3><u>FOR SERVERS:</u></h3>
              <p style= text-align: justify;><b>Write down the confirmation code on the table's receipt or your POS system</b>.  Place a  \"Buy One, Feed One\"  placard on the guest's table, and mark a tally on your chalkboard (if available).  Call us at 312 945 8627 with any questions!</p></td></tr></table>"
      end
    end
  end

  def signupsuccess(user)
    mail = Mail.deliver do
      to user.email
      from 'FoodCircles <hey@foodcircles.net>'
      subject "Your Hunger is Powerful."
      reply_to 'hey@foodcircles.net'
      html_part do
        content_type 'text/html; charset=UTF-8'
        body "<p>You did it. You signed up for FoodCircles. But why? ...well, maybe you can relate to this situation.<br>
              If you're like me, you love to dine out. But the thing is, I can't ever decide on where to go. \"You pick.\" \"Hahaha, no, you pick.\" Geez.....<br>
              There's also certain beliefs I have about the world. That no one should go hungry, that I'm fortunate to be in the position I'm in, and that any kid should be able to choose to study or play when they want to -- not just when their stomach allows it.<br>
              Our new site lets you try a dish at top local restaurants for just $1, and directs 100% of that purchase to get dinner to a child who needs it. Thank you so much for joining us.<br>
              <a href=\"http://www.joinfoodcircles.org\">Grab A $1 Dish Here</a><br><br>
              Buen provecho,<br>
              Jonathan  312 945 8627</p>"
      end
    end
  end

  def voucher(user, r)
    @user = user
    @r = r
    mail(:to => @user.email, :subject => "Your voucher for #{r.venue.name.capitalize}")
  end


  def create_voucher(user, r)

    #tkxel_dev: send Emails to users.
    @user = user
    @r = r
    setup_email(@user, @r)
    #mail_for_voucher(:to => @user.email,
    #  :subject => "Your voucher for #{r.venue.name.capitalize.gsub(/\'/,"\\\'") }",
    #  :reservation => r )
    #mail(:to => 'jinnahrae@gmail.com', :subject => "An email for test")
  end

  def remind_mail(to)
    mail_for_remind(:to => to, :subject => "Newsletter Mail")
  end

  def social_butterfly(fb)
    mail(:to => ADMIN_EMAIL, :subject => "Social Butterfly Matchmaking", :body => "Someone would like to apply for Social Butterflies! Their profile is #{fb}")
  end

  def restaurant_signup(email, name)
    mail(:to => email, :subject => "Thanks for signing up.", :body => "Someone will get back with you soon, #{name}.")
  end

  def restaurant_notify(email, name)
    mail(:to => ADMIN_EMAIL, :subject => "New Restaurant Request", :body => "#{name} would like to join FoodCircles. Please contact them at #{email}.")
  end

  def company_signup(email, name, company)
    mail(:to => email, :subject => "Thanks for signing up.", :body => "Someone will get back with you soon, #{name}.")
  end

  def company_notify(email, name, company)
    mail(:to => ADMIN_EMAIL, :subject => "New Company Request", :body => "#{name} from #{company} would like to join FoodCircles. Please contact them at #{email}.")
  end

  def nonprofits_signup(email, name)
    mail(:to => email, :subject => "Thanks for your interest.", :body => "Someone will get back with you soon, #{name}.")
  end

  def nonprofits_notify(email, name, organization, website, from_grand_rapids = false)
    subject = "New Buy One, Feed One Request"
    subject += " from Grand Rapids" if from_grand_rapids
    mail(:to => ADMIN_EMAIL, :subject => subject, :body => "#{name} from #{organization} would like to join FoodCircles. Their website is  #{website}. Please contact them at #{email}.")
  end

  def students_signup(email)
    mail(:to => email, :subject => "Thanks for your interest.", :body => "Someone will get back with you soon.")
  end

  def students_notify(email)
    mail(:to => ADMIN_EMAIL, :subject => "New Student Request", :body => "A student would like to join FoodCircles. Please contact them at #{email}.")
  end

  def organizers_signup(email)
    mail(:to => email, :subject => "Thanks for your interest.", :body => "Someone will get back with you soon.")
  end

  def organizers_notify(email, location, address, date, num_diners, occassion, budget, food_preferences, donation, feedback)
    mail(:to => ADMIN_EMAIL, :subject => "New Organizers Request", :body => "An organizer would like to join FoodCircles. They will be dining #{location} on #{date} with #{num_diners} guests. The occasion is #{occassion} with a budget of #{budget}. Their food preferences include #{food_preferences}. They would like to donate #{donation}. They provided the following feedback: #{feedback}. Please contact them at #{email}")
  end

  def notification_about_available_vouchers(user, venue)
    @name = user.name || "Hey"
    @restaurant_name = venue.name
    @restaurant_url = venue_popup_url(venue)
    mail(:to => user.email, :subject => "Pending")
  end

  def monthly_invoice(venue, months_before = 1)
    @calculations = Calculations::Monthly.new(venue, months_before)
    mail(:to => ADMIN_EMAIL, :subject => "A Monthly Report from FoodCircles")
  end

  def postcard_notification(postcard)
    @postcard = postcard
    mail(:to => SUPPORT_EMAIL, :subject => "Postcard Alert")
  end

  def voucher_expiring_soon(payment)
    @payment = payment.decorate

    mail(:to => payment.user.email, :subject => "FoodCircles Voucher Expiring Soon")
  end

end
