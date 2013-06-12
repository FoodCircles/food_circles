class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :offer

  before_save :add_code

  scope :total_week_payments, where("created_at >= ?", Time.now - 1.week)

  def add_code
    unless self.code
      chars = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
      self.code = (0...6).map{ chars[rand(chars.length)] }.join
    end
  end
end
