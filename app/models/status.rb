class Status < ActiveRecord::Base
  has_many :payments
  has_many :reservations
end