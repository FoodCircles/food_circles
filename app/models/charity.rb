class Charity < ActiveRecord::Base
  image_accessor :image
  image_accessor :logo
  image_accessor :photo

  belongs_to :charity
  belongs_to :region
  belongs_to :state
  has_many :payments
  has_many :follow_up_notes

  CHARITY_TYPE_ENUM = %w(main extra)

  validates :name, presence: true
  validates :charity_type, presence: true, :inclusion => {:in => CHARITY_TYPE_ENUM}

  def charity_type_enum
    CHARITY_TYPE_ENUM
  end

  def as_json(options={})
    { :id => self.id,
      :name => self.name,
      :address => self.address,
      :city => self.city,
      :description => self.description,
      :state => self.state.name,
      :image => self.image.present? ? self.image.url : ''
    }
  end

  def full_address
    "#{self.address}, #{self.city}, #{self.state.name}"
  end

end
