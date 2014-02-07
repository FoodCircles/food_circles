class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  ADMIN_EMAIL = 'jk@joinfoodcircles.org'
  SUPPORT_EMAIL = 'support@joinfoodcircles.org'

  #tkxel_dev: SendGrid credentilas for email.
  default from: "\"FoodCircles\" <voucher@foodcircles.net>"
  require 'mail'
  Mail.defaults do
    delivery_method :smtp, {:address => "smtp.mandrillapp.com",
                            :port => 587,
                            :domain => "foodcircles.net",
                            :user_name => "jk@joinfoodcircles.org",
                            :password => "uQjfYEZZxNUpGq0oeoVjmw",
                            :authentication => 'plain',
                            :enable_starttls_auto => true}
  end
  #tkxel_dev: Send email upon voucher creation
  def food_mail(email)

    @url = 'http://foodcircles.net/?app=mobile_email'
    mail(:to => email, :reply_to => 'jk@joinfoodcircles.org', :subject => "Your appetite is powerful.")
  end

  #tkxel_dev: Email Content creation is handled in the following method.
  def setup_email(user, payment)
    mail = Mail.deliver do
      to user.email
      from 'FoodCircles <hey@joinfoodcircles.org>'
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
              Contact support at <b>support@joinfoodcircles.org</b> if you have any concerns or questions whatsoever.<br><br><br>
              <h3><u>FOR SERVERS:</u></h3>
              <p style= text-align: justify;><b>Write down the confirmation code on the table's receipt or your POS system</b>.  Place a  \"Buy One, Feed One\"  placard on the guest's table, and mark a tally on your chalkboard (if available).  Call us at 312 945 8627 with any questions!</p></td></tr></table>"
      end
    end
  end

  def signupsuccess(user)
    mail = Mail.deliver do
      to user.email
      from 'FoodCircles <hey@joinfoodcircles.org>'
      subject "Your Hunger is Powerful."
      reply_to 'hey@joinfoodcircles.org'
      html_part do
        content_type 'text/html; charset=UTF-8'
        head "
        <style>a:hover{text-decoration:underline!important}td.promocell p{color:#766a64;font-size:16px;line-height:26px;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;7666 margin-top:0;margin-bottom:0;padding-top:0;padding-bottom:14px;font-weight:400}td.contentblock h4{color:#766a64!important;font-size:16px;line-height:24px;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;margin-top:0;margin-bottom:10px;padding-top:0;padding-bottom:0;font-weight:400}td.contentblock h4 a{color:#766a64;text-decoration:none}td.contentblock p{color:#766a64;font-size:13px;line-height:19px;font-family:'Helvetica Neue',Helvetica,Arial,sans-serif;margin-top:0;margin-bottom:12px;padding-top:0;padding-bottom:0;font-weight:400}td.contentblock p a{color:#766a64;text-decoration:none}@media only screen and (max-device-width:480px){div[class=header]{font-size:16px!important}table[class=table],td[class=cell]{width:300px!important}table[class=promotable],td[class=promocell]{width:325px!important}td[class=footershow]{width:300px!important}img[class=hide],table[class=hide],td[class=hide]{display:none!important}img[class=divider]{height:1px!important}td[class=logocell]{padding-top:15px!important;padding-left:15px!important;width:300px!important}img[id=screenshot]{width:325px!important;height:127px!important}img[class=galleryimage]{width:53px!important;height:53px!important}p[class=reminder]{font-size:11px!important}h4[class=secondary]{line-height:22px!important;margin-bottom:15px!important;font-size:18px!important}}</style>"
        
        body "<body bgcolor=\"#f2f2f2\" topmargin=\"0\" leftmargin=\"0\" marginheight=\"0\" marginwidth=\"0\" style=\"-webkit-font-smoothing: antialiased;width:100% !important;background:#f2f2f2;-webkit-text-size-adjust:none;\"> <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" bgcolor=\"#f2f2f2\"> <tr> <td bgcolor=\"#f2f2f2\" width=\"100%\"> <table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" align=\"center\" class=\"table\"> <tr> <td width=\"600\" class=\"cell\"> <table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"table\"> <tr> <td width=\"250\" bgcolor=\"#f2f2f2\" class=\"logocell\"><img border=\"0\" src=\"images/spacer.gif\" width=\"1\" height=\"20\" class=\"hide\"><br class=\"hide\"> </tr> </table> <a href=\"http://www.joinfoodcircles.org\"><img border=\"0\" src=\"images/header.png\" label=\"Food Circles | joinfoodcircles.org\" editable=\"true\" width=\"600\" height=\"150\" id=\"screenshot\"></a> <table width=\"600\" cellpadding=\"25\" cellspacing=\"0\" border=\"0\" class=\"promotable\"> <tr> <td bgcolor=\"#fff\" width=\"600\" class=\"promocell\"> <multiline label=\"Main feature intro\"><p style=\"color:#766a64;font-size:20px;font-family:Baskerville;margin-top:0;margin-bottom:15px;padding-top:0;padding-bottom:0;line-height:18px;font-weight: bold;\"><!-- Thank you for signing up. --> <img src=\"images/thank-you.png\" alt=\"Thank you for signing up.\" title=\"Thank you for signing up.\"></p> <p style=\"color:#404040;\">You did it. You signed up for FoodCircles. But why? ...maybe you can relate to this situation. <br><br> If you're like me, you love to dine out. But the thing is, I can't ever decide on where to go. \"You pick.\" \"Hahaha, no, you pick.\" Geez..... <br><br> There's also certain beliefs I have about the world. No one should go hungry, I'm fortunate to be in the position I'm in, and any kid should be able to choose to study or play when they want to &#8212; not just when their stomach allows it. <br><br> FoodCircles lets you buy an appetizer, drink, or dessert at top local restaurants for only $1, and directs 100% of your purchase to get dinner to a child who needs it. <b>Buy one, feed one</b>. A simple way to know where to eat and feed a hungry child in the process. </p> <p> <a href=\"http://www.joinfoodcircles.org/#home\"><img border=\"0\" src=\"images/grabadish.png\" alt=\"Grab a dish.\" width=\"548\" height=\"162\" /></a> </p> </multiline> <p style=\"color:#000;float:left;font-size:12px;line-height: 20px;\"> Buen provercho, <br> <i>The Food Circles Team</i> </p> <p style=\"color:#000;float:right;font-size:12px;\"> <a href=\"http://www.facebook.com/FoodCircles\"><img border=\"0\" src=\"images/facebook.png\" alt=\"Facebook\" width=\"52\" height=\"53\" /></a> <a href=\"http://twitter.com/FoodCircles\"><img border=\"0\" src=\"images/twitter.png\" alt=\"Twitter\" width=\"52\" height=\"53\"/></a> </p> </td> </tr> </table> <img border=\"0\" src=\"images/spacer.gif\" width=\"1\" height=\"15\" class=\"divider\"><br> </td> </tr> </table> <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" bgcolor=\"#f2f2f2\"> <tr> <td> <table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" align=\"center\" class=\"table\"> <tr> <td width=\"600\" nowrap bgcolor=\"#f2f2f2\" class=\"cell\"> <center style=\"text-align: center;\"> <ul> <li style=\"float:left;color:#808080;font-family:Helvetica;font-size:12px;list-style:none;border-right: 25px solid #f2f2f2;border-left: 75px solid #f2f2f2;\">View In Browser</li> <li style=\"float:left;color:#808080;font-family:Helvetica;font-size:12px;list-style:none;border-right: 25px solid #f2f2f2;\">Unsubscribe</li> <li style=\"float:left;color:#808080;font-family:Helvetica;font-size:12px;list-style:none;border-right: 25px solid #f2f2f2;\">Update Profile</li> <li style=\"float:left;color:#808080;font-family:Helvetica;font-size:12px;list-style:none;border-right: 25px solid #f2f2f2;\">Forward</li> </ul> <br><p style=\"font-family:Helvetica;color:#808080;font-size:12px;\">user@totallycoolwebsite.com</p> <p style=\"font-family:Helvetica;color:#808080;font-size:12px;\">This email was sent to user@totallycoolwebsite.com because you signed up to be notified about Food Circles</p> </center> <table width=\"600\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" class=\"table\"> </table> </td> </tr> </table> <img border=\"0\" src=\"images/spacer.gif\" width=\"1\" height=\"25\"><br> </td> </tr> </table> </td> </tr> </table> </body>"
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
    mail(:to => 'bshell@joinfoodcircles.org', cc: ADMIN_EMAIL, :subject => "New Organizers Request", :body => "An organizer would like to join FoodCircles. They will be dining #{location} on #{date} with #{num_diners} guests. The occasion is #{occassion} with a budget of #{budget}. Their food preferences include #{food_preferences}. They would like to donate #{donation}. They provided the following feedback: #{feedback}. Please contact them at #{email}")
  end

  def notification_about_available_vouchers(user, venue)
    @name = user.name || "Hey"
    @restaurant_name = venue.name
    @restaurant_url = venue_popup_url(venue)
    mail(:to => user.email, :subject => "Dish Available!")
  end

  def monthly_invoice(venue, months_before = 1)
    @calculations = Calculations::Monthly.new(venue, months_before)
    mail(:to => ADMIN_EMAIL, :subject => "Report from FoodCircles for the month of #{@calculations.month}.")
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
