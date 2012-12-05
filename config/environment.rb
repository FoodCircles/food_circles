# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Foodcircles::Application.initialize!
=begin
ActionMailer::Base.smtp_settings = {
  :user_name => "jtkumario",
  :password => "Forecast1",
  :domain => "foodcircles.net",
  :address => "smtp.sendgrid.net",
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
=end
#if ENV['RAILS_ENV'] ||= 'staging'
#  ENV['RAILS_ENV'] ||= 'staging'
#else
#  ENV['RAILS_ENV'] ||= 'development'
#end

ActionMailer::Base.raise_delivery_errors = true
#ActionMailer::Base.add_delivery_method :msmtp, Mail::SMTP
#ActionMailer::Base.delivery_method = :msmtp
module ActionMailer
  class Base
    def mail_for_signupsuccess(info)
    	to       = info[:to]
    	from     = '"FoodCircles" <info@foodcircles.net>'
    	subject  = "Congratulations!"
    	body     = File.read(Rails.root.to_s+"/app/views/user_mailer/signupsuccess.html.erb")
      _mail( :to=>to, :from=>from, :subject=>subject, :body=>body )
    end

    def mail_for_voucher(info)
      to       = info[:to]
      from     = '"FoodCircles" <info@foodcircles.net>'
      subject  = info[:subject] #{}"Voucher Created!"
      body     = File.read(Rails.root.to_s+"/app/views/user_mailer/voucher_create.html.erb")
      r = info[:reservation]

      body = body.gsub(/___COUPON___/,"'"+r.coupon+"'")
      body = ERB.new(body).result
      _mail( :to=>to, :from=>from, :subject=>subject, :body=>body )
    end

    def mail_for_remind(info)
      to       = info[:to]
      from     = '"FoodCircles" <info@foodcircles.net>'
      subject  = info[:subject]

      body     = File.read(Rails.root.to_s+"/app/views/user_mailer/remind_mail.html.erb")
      _mail( :to=>to, :from=>from, :subject=>subject, :body=>body )
    end

    def _mail(info)
      to = info[:to]
      from = info[:from]
      subject = info[:subject]
      body = info[:body]

      file = Tempfile.new('mail')
      file = (0...8).map{65.+(rand(26)).chr}.join + ".mail"
      `echo 'To: #{to}\nFrom: #{from}\nSubject: #{subject}\nMIME-Version: 1.0\nContent-Type: text/html\n\n#{body}' > #{file}`
      `cat #{file} | /usr/bin/msmtp -a jtkumario #{to}`
      `rm #{file} -rf`
    end
  end
end

module ActionMailera
  class Base
    def perform_delivery_msmtp(mail)
      IO.popen("/usr/bin/msmtp -t -a jtkumario --", "w") do |sm|
        sm.puts(mail.encoded.gsub(/\r/, ''))
        sm.flush
      end
      unless $?.success?
        logger.error("failed to send mail errno #{$?.exitstatus}")
      end
    end
  end
end