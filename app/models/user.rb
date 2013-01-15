class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone, :admin
  has_many :reservations
  has_many :venues

  before_save :format

  def is_admin?
    self.admin
  end

  def format
    self.phone.gsub!(/[^0-9]/,"") if self.phone
  end
end
