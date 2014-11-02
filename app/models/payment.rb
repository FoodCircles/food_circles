class Payment < ActiveRecord::Base
  EXPIRATION_DAYS = 30
  EXPIRING_SOON_DAYS = 7
  FOLLOW_UP_DAYS = 4

  belongs_to :user
  belongs_to :offer
  belongs_to :charity

  before_save :add_code
  before_save :default_charity

  scope :total_week_payments, where("created_at >= ?", Date.today.beginning_of_week(:saturday))

  scope :active_payments, where("state is null OR state = 'Active'")

  scope :valid_payments, where("offer.venue is not null")

  scope :expiring_soon, lambda { where("created_at > ? and created_at < ?", expiring_soon_date, expiring_soon_date + 24.hours) }

  scope :follow_up, lambda { where("created_at > ? and created_at < ?", follow_up_date, follow_up_date + 24.hours) }

  def add_code
    unless self.code
      chars = [('a'..'z'), ('0'..'9')].map { |i| i.to_a }.flatten
      self.code = (0...5).map { chars[rand(chars.length)] }.join.upcase
    end
  end

  def default_charity
    unless self.charity_id
      self.charity_id = 1
      logger.warn "Had to change charity_id to = 1, check the database, something is wrong!"
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

  def self.follow_up_date
    FOLLOW_UP_DAYS.days.ago.to_date
  end

end
