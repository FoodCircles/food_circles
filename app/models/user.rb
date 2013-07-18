class User < ActiveRecord::Base
  include Validators

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable,
         :omniauthable, :omniauth_providers => [:facebook, :twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :phone, :admin, :uid, :provider, :stripe_customer_token
  validates :email, :on => :update, :'validators/email' => true
  validates :email, :on => :create, :allow_nil => true, :'validators/email' => true
  has_many :reservations
  has_many :venues

  before_save :format
  
  before_save :ensure_authentication_token
  

  def is_admin?
    self.admin
  end

  def format
    self.phone.gsub!(/[^0-9]/,"") if self.phone
  end

  # Setup OmniAuth

  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         email:auth.info.email,
                         uid:auth.uid,
                         password:Devise.friendly_token[0,20]
                        )
    end
    user
  end

  def self.find_for_twitter_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.info.name,
                         provider:auth.provider,
                         email: "#{auth.info.nickname}@twitter.com",
                         uid:auth.uid,
                         password:Devise.friendly_token[0,20]
                        )
    end
    user
  end

end
