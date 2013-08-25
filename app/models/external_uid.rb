class ExternalUID < ActiveRecord::Base
  belongs_to :user

  validates :uid, :uniqueness => true, :presence => true
end
