class UserBadge < ActiveRecord::Base
  belongs_to :user
  belongs_to :badge
  attr_accessible :sent_email
end
