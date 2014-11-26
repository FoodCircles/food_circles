class CharityPhoto < ActiveRecord::Base
  image_accessor :photo

  validates :photo, presence: true
  belongs_to :charity


end
