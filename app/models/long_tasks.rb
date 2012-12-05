class LongTasks < ActiveRecord::Base
  def self.handle_email(r)
    UserMailer.delay.voucher(current_user, r)
  end

  def self.handle_text(r)
    begin
      if current_user.phone
        code = (current_user.name ? "#{current_user.name.titleize} for #{r.offer.min_diners}" : r.coupon)
        sendText(current_user.phone,"Thank you for using Foodcircles! Your code is \"#{code}\" for #{r.offer.name} at #{r.venue.name}.")
      end
    rescue
      #we tried
    end
  end
  handle_asynchronously :handle_text
end
