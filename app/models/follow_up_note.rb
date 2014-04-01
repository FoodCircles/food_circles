class FollowUpNote < ActiveRecord::Base
  belongs_to :charity
  attr_accessible :note, :charity_id

  validates :note, presence: true
end
