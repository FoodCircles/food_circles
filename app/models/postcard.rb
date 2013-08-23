class Postcard < ActiveRecord::Base
  after_create :notify_support

  def notify_support
    UserMailer.postcard_notification(self).deliver
  end
end
