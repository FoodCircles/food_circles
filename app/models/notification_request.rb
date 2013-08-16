class NotificationRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue

  validates :venue_id, :uniqueness => {:scope => :user_id, :message => "You had already asked for notification"}, :presence => true
  validates :user_id, :presence => true
end
