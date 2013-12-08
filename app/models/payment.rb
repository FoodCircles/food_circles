class Payment < ActiveRecord::Base
  EXPIRATION_DAYS = 30
  EXPIRING_SOON_DAYS = 7

  belongs_to :user
  belongs_to :offer
  belongs_to :charity

  before_save :add_code

  scope :total_week_payments, where("created_at >= ?", Date.today.beginning_of_week(:saturday))

  scope :active_payments, where("state is null OR state = 'Active'")

  scope :expiring_soon, lambda { where("created_at > ? and created_at < ?", expiring_soon_date, expiring_soon_date + 24.hours) }

  def add_code
    unless self.code
      chars = [('a'..'z'), ('0'..'9')].map { |i| i.to_a }.flatten
      self.code = (0...5).map { chars[rand(chars.length)] }.join.upcase
    end
  end

  def active?
    state.nil? || state == "Active"
  end

  def expired?
    state == "Expired"
  end

  def used?
    state == "Used"
  end

  def expiring_at
    created_at + EXPIRATION_DAYS.days
  end

  private

  def self.expiring_soon_date
    (EXPIRATION_DAYS - EXPIRING_SOON_DAYS).days.ago.to_date
  end

end
