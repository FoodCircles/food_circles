class Payment < ActiveRecord::Base
  belongs_to :user
  belongs_to :offer

  before_save :add_code

  def add_code
    unless self.code
      chars = [('a'..'z'),('0'..'9')].map{|i| i.to_a}.flatten
      self.code = (0...6).map{ chars[rand(chars.length)] }.join
    end
  end
end
