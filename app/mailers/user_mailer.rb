class UserMailer < ActionMailer::Base
  add_template_helper(ApplicationHelper)

  ADMIN_EMAIL = 'jk@joinfoodcircles.org'
  SUPPORT_EMAIL = 'support@joinfoodcircles.org'

  #fc_dev: Mandrill credentials for email.
  default from: "\"FoodCircles\" <hey@joinfoodcircles.org>"
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
    mail(:to => email, :reply_to => 'jk@joinfoodcircles.org', :subject => "Your hunger is powerful.")
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
        body "<body leftmargin=\"0\" marginwidth=\"0\" topmargin=\"0\" marginheight=\"0\" offset=\"0\" style=\"background-color: #f2f2f2;-webkit-text-size-adjust: none;margin: 0;padding: 0;width: 100%;\"> <center> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" height=\"100%\" width=\"100%\" id=\"backgroundTable\" style=\"padding-top: 30px;margin: 0;padding: 0;background-color: #f2f2f2;height: 100%;width: 100%;\"> <tr> <td align=\"center\" valign=\"top\" style=\"border-collapse: collapse;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" id=\"templateContainer\" style=\"border: 0px solid #DDDDDD;background-color: #FFFFFF;\"> <tr> <td align=\"center\" valign=\"top\" style=\"border-collapse: collapse;\"> <!-- // Begin Template Header \ --> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" id=\"templateHeader\" style=\"background-color: #FFFFFF;border-bottom: 0;\"> <tr> <td class=\"headerContent\" style=\"border-collapse: collapse;color: #4e3e34;font-family: Arial;font-size: 34px;font-weight: bold;line-height: 100%;padding: 0;text-align: center;vertical-align: middle;\"> <!-- // Begin Module: Standard Header Image \ --> <img src=\"http://gallery.mailchimp.com/ae083950237bb7c8e292ebda4/images/header.png\" style=\"max-width: 600px;border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;\" id=\"headerImage campaign-icon\" mc:label=\"header_image\" mc:edit=\"header_image\" mc:allowdesigner=\"\" mc:allowtext=\"\"> <!-- // End Module: Standard Header Image \ --> </td> </tr> </table> <!-- // End Template Header \ --> </td> </tr> <tr> <td align=\"center\" valign=\"top\" style=\"border-collapse: collapse;\"> <!-- // Begin Template Body \ --> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" id=\"templateBody\" style=\"background-color: #fff;\"> <tr> <td valign=\"top\" class=\"bodyContent\" style=\"color: #766a64;font-family: Arial;font-size: 16px;line-height: 150%;text-align: left;border-collapse: collapse;background-color: #FFFFFF;\"> <!-- // Begin Module: Standard Content \ --> <table border=\"0\" cellpadding=\"20\" cellspacing=\"0\" width=\"100%\"> <tr> <td valign=\"top\" style=\"border-collapse: collapse;\"> <br> <img src=\"http://www.joinfoodcircles.org/email-templates/header-titles/your-voucher.png\" alt=\"Your voucher.\" mc:edit=\"header-text\" style=\"border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;display: inline;\"><br><br> <div mc:edit=\"std_content00\" style=\"color:#766a64; font-family:Arial; font-size:16px; line-height:150%; text-align:left;\"> <p>Print this email or just show it off on a fancy electronic device.</p> <p> <b>confirmation code:</b> #{payment.code}<br> <b>good for:</b> #{payment.offer.name}<br> <b>only at:</b> #{payment.offer.venue.name}<br> <b>with a minimum of:</b> #{payment.offer.min_diners} diners<br> <b>expiring:</b> #{30.days.from_now.to_date}</p><br> <b>3 steps to redeem:</b> <p> <b>1)</b> Show server this message before you order. They should jot your code down and confirm.<br> <b>2)</b> Order regular food or drink for each person in party.<br> <b>3)</b> Mark Voucher as used by clicking below. <br> <a href=\"http://staging.foodcircles.net/payment/used?code=#{payment.code}&source=email\"><img src=\"http://f.cl.ly/items/3E2T1U2b240a270B0c2R/mark-as-used.png\" alt=\"Mark as Used\" align=\"middle\" height=\"136\" width=\"458\"></a></br> </p><br><br> Enjoy!<br><br> Contact support at <b>support@joinfoodcircles.org</b> if you have any concerns or questions whatsoever.<br><br><br> <h3><u>FOR SERVERS:</u></h3> <p><b>Write down the confirmation code on the table's receipt or your POS system</b>. Place a \"Buy One, Feed One\" placard on the guest's table, and mark a tally on your chalkboard (if available). Call us at 312 945 8627 with any questions!</p> </div> </td> </tr> </table> <!-- // End Module: Standard Content \ --> </td> </tr> </table> <!-- // End Template Body \ --> </td> </tr> <tr> <td align=\"center\" valign=\"top\" style=\"border-collapse: collapse;\"> <!-- // Begin Template Footer \ --> <table border=\"0\" cellpadding=\"10\" cellspacing=\"0\" width=\"600\" id=\"templateFooter\" style=\"background-color: #FFFFFF;border-top: 0;\"> <tr> <td valign=\"top\" class=\"footerContent\" style=\"border-collapse: collapse;\"> <!-- // Begin Module: Standard Footer \ --> <table border=\"0\" cellpadding=\"10\" cellspacing=\"0\" width=\"100%\"> <tr> <td valign=\"top\" width=\"350\" style=\"border-collapse: collapse;\"> <br> <div mc:edit=\"std_footer\" class=\"std_footer\" style=\"color: #707070;font-weight: normal;padding-left: 10px;font-family: Arial;font-size: 12px;line-height: 125%;text-align: left;\"> Your friends, <br> <i>The FoodCircles Team</i> </div> </td> <td valign=\"top\" width=\"190\" id=\"socialicons\" style=\"border-collapse: collapse;\"> <div style=\"color: #707070;font-family: Arial;font-size: 12px;line-height: 125%;text-align: left;\"> <a href=\"http://www.facebook.com/FoodCircles\" style=\"color: #336699;font-weight: normal;text-decoration: underline;\"><img border=\"0\" src=\"http://gallery.mailchimp.com/ae083950237bb7c8e292ebda4/images/facebook.png\" alt=\"Facebook\" width=\"52\" height=\"53\" style=\"border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;display: inline;max-width: 190px;float: right;\"></a> <a href=\"http://twitter.com/FoodCircles\" style=\"color: #336699;font-weight: normal;text-decoration: underline;\"><img border=\"0\" src=\"http://gallery.mailchimp.com/ae083950237bb7c8e292ebda4/images/twitter.png\" alt=\"Twitter\" width=\"52\" height=\"53\" style=\"border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;display: inline;max-width: 190px;float: right;\"></a> </div> </td> </tr> </table> </td></tr> <!-- // End Module: Standard Footer \ --> </table></td> </tr> </table> <!-- // End Template Footer \ --> </td></tr> </table> <br> </center> </body> </html>"
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
        body "<body leftmargin=\"0\" marginwidth=\"0\" topmargin=\"0\" marginheight=\"0\" offset=\"0\" style=\"background-color: #f2f2f2;-webkit-text-size-adjust: none;margin: 0;padding: 0;width: 100%;\"> <center> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" height=\"100%\" width=\"100%\" id=\"backgroundTable\" style=\"padding-top: 30px;margin: 0;padding: 0;background-color: #f2f2f2;height: 100%;width: 100%;\"> <tr> <td align=\"center\" valign=\"top\" style=\"border-collapse: collapse;\"> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" id=\"templateContainer\" style=\"border: 0px solid #DDDDDD;background-color: #FFFFFF;\"> <tr> <td align=\"center\" valign=\"top\" style=\"border-collapse: collapse;\"> <!-- // Begin Template Header \ --> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" id=\"templateHeader\" style=\"background-color: #FFFFFF;border-bottom: 0;\"> <tr> <td class=\"headerContent\" style=\"border-collapse: collapse;color: #4e3e34;font-family: Arial;font-size: 34px;font-weight: bold;line-height: 100%;padding: 0;text-align: center;vertical-align: middle;\"> <!-- // Begin Module: Standard Header Image \ --> <img src=\"http://gallery.mailchimp.com/ae083950237bb7c8e292ebda4/images/header.png\" style=\"max-width: 600px;border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;\" id=\"headerImage campaign-icon\" mc:label=\"header_image\" mc:edit=\"header_image\" mc:allowdesigner=\"\" mc:allowtext=\"\"> <!-- // End Module: Standard Header Image \ --> </td> </tr> </table> <!-- // End Template Header \ --> </td> </tr> <tr> <td align=\"center\" valign=\"top\" style=\"border-collapse: collapse;\"> <!-- // Begin Template Body \ --> <table border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"600\" id=\"templateBody\" style=\"background-color: #fff;\"> <tr> <td valign=\"top\" class=\"bodyContent\" style=\"color: #766a64;font-family: Arial;font-size: 16px;line-height: 150%;text-align: left;border-collapse: collapse;background-color: #FFFFFF;\"> <!-- // Begin Module: Standard Content \ --> <table border=\"0\" cellpadding=\"20\" cellspacing=\"0\" width=\"100%\"> <tr> <td valign=\"top\" style=\"border-collapse: collapse;\"> <img src=\"http://www.joinfoodcircles.org/email-templates/header-titles/thank-you.png\" alt=\"Thank you for signing up.\" mc:edit=\"header-text\" style=\"border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;display: inline;\"><br><br> <div mc:edit=\"std_content00\" style=\"color:#766a64; font-family:Arial; font-size:16px; line-height:150%; text-align:left;\">You did it. You signed up for FoodCircles. But why? ...maybe you can relate to this situation.<br> <br> If you're like me, you love to dine out. But the thing is, I can't ever decide on where to go. \"You pick.\" \"Hahaha, no, you pick.\" Geez.....<br> <br> There's also certain beliefs I have about the world. No one should go hungry, I'm fortunate to be in the position I'm in, and any kid should be able to choose to study or play when they want to &#8212; not just when their stomach allows it.<br> <br> FoodCircles lets you buy an appetizer, drink, or dessert at top local restaurants for only $1, and directs 100% of your purchase to get dinner to a child who needs it. <b>Buy one, feed one</b>. A simple way to know where to eat and feed a hungry child in the process.</p> </div> </td> </tr> </table> <!-- // End Module: Standard Content \ --> </td> </tr> </table> <!-- // End Template Body \ --> </td> </tr> <tr> <td align=\"center\" valign=\"top\" style=\"border-collapse: collapse;\"> <!-- // Begin Template Footer \ --> <table border=\"0\" cellpadding=\"10\" cellspacing=\"0\" width=\"600\" id=\"templateFooter\" style=\"background-color: #FFFFFF;border-top: 0;\"> <tr> <td valign=\"top\" class=\"footerContent\" style=\"border-collapse: collapse;\"> <!-- // Begin Module: Standard Footer \ --> <table border=\"0\" cellpadding=\"10\" cellspacing=\"0\" width=\"100%\"> <tr> <td valign=\"top\" width=\"350\" style=\"border-collapse: collapse;\"> <br> <div mc:edit=\"std_footer\" class=\"std_footer\" style=\"color: #707070;font-weight: normal;padding-left: 10px;font-family: Arial;font-size: 12px;line-height: 125%;text-align: left;\"> Your friends, <br> <i>The FoodCircles Team</i> </div> </td> <td valign=\"top\" width=\"190\" id=\"socialicons\" style=\"border-collapse: collapse;\"> <div style=\"color: #707070;font-family: Arial;font-size: 12px;line-height: 125%;text-align: left;\"> <a href=\"http://www.facebook.com/FoodCircles\" style=\"color: #336699;font-weight: normal;text-decoration: underline;\"><img border=\"0\" src=\"http://gallery.mailchimp.com/ae083950237bb7c8e292ebda4/images/facebook.png\" alt=\"Facebook\" width=\"52\" height=\"53\" style=\"border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;display: inline;max-width: 190px;float: right;\"></a> <a href=\"http://twitter.com/FoodCircles\" style=\"color: #336699;font-weight: normal;text-decoration: underline;\"><img border=\"0\" src=\"http://gallery.mailchimp.com/ae083950237bb7c8e292ebda4/images/twitter.png\" alt=\"Twitter\" width=\"52\" height=\"53\" style=\"border: 0;height: auto;line-height: 100%;outline: none;text-decoration: none;display: inline;max-width: 190px;float: right;\"></a> </div> </td> </tr> </table> </td></tr> <!-- // End Module: Standard Footer \ --> </table></td> </tr> </table> <!-- // End Template Footer \ --> </td></tr> </table> <br> </center> </body>"
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

  def voucher_expiring_soon(payment_id)
    payment = Payment.find_by_id(payment_id)
    @payment = payment.decorate

    mail(:to => payment.user.email, :reply_to => 'used@inbound.foodcircles.net', :subject => "FoodCircles Voucher Expiring Soon")
  end

  def badge_email(email, category, title)
    @category = category
    @title = title
    mail(
      :to => email,
      :from => 'hey@joinfoodcircles.org',
      :cc => 'gs@joinfoodcircles.org',
      :reply_to => 'gs@joinfoodcircles.org',
      :subject => 'Have a little something for you. Need address.'
    )
  end

end
