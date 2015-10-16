class Charity < ActiveRecord::Base
  image_accessor :image
  image_accessor :logo
  image_accessor :photo

  default_scope order('charities.order ASC')

  belongs_to :charity
  belongs_to :region
  belongs_to :state
  has_many :payments
  has_many :follow_up_notes
  has_many :charity_photos

  CHARITY_TYPE_ENUM = %w(main extra)
  SRID = 4326

  set_rgeo_factory_for_column(:latlon,
                              RGeo::Geographic.spherical_factory(:srid => SRID))

  validates :name, presence: true
  validates :charity_type, presence: true, :inclusion => {:in => CHARITY_TYPE_ENUM}

  before_save :update_latlon, :if => :dirty_latlon?

  rails_admin do
    edit do
      configure :subdomain do
        label "Desired Subdomain"
      end
      configure :charity_type, :enum do
        label "Charity Type"
        enum do
          CHARITY_TYPE_ENUM
        end
      end
      configure :use_funds do
        label "Use of Funds"
      end
    end
  end

  def self.active
    where(:active => true)
  end

  def self.within_radius_of_location(latitude, longitude, radius = 80467.2)
    return Charity.scoped unless latitude && longitude
    Charity.where(
      "ST_Distance(charities.latlon, 'POINT(? ?)') <= ?",
      longitude.to_f,
      latitude.to_f,
      radius
    )
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

  def lat
    @lat ||= if latlon.present?
      latlon.lat
    end
  end

  def lat=(value)
    @lat = value
  end

  def lon
    @lon ||= if latlon.present?
      latlon.lon
    end
  end

  def lon=(value)
    @lon = value
  end

  def full_address
    "#{self.address}, #{self.city}, #{self.state.name}"
  end

  def raw_msg_usefunds(amt)
    uf = self.use_funds.dup
    uf['%amt%'] = amt.to_s if uf.include? '%amt%'

    amt_mult = uf.match('%amt:([0-9\.]+)%')
    uf[amt_mult[0]] = (amt.to_f*amt_mult[1].to_f).to_s unless amt_mult.nil?

    if uf.include? '%s%'
      if amt > 1
        uf['%s%'] = 's'
      else
        uf['%s%'] = ''
      end
    end

    if uf.include? '%ren%'
      if amt > 1
        uf['%ren%'] = 'ren'
      else
        uf['%ren%'] = ''
      end
    end
    return uf
  end

  def msg_usefunds(amt)
    raw = raw_msg_usefunds(amt)

    return ActionController::Base.helpers.strip_tags(raw)

  end

  private

  def dirty_latlon?
    if latlon.present?
      lat != latlon.lat || lon != latlon.lon
    else
      lat.present? && lon.present?
    end
  end

  def update_latlon
    new_latlon = Charity.rgeo_factory_for_column(:latlon).point(lon, lat)
    self.latlon = new_latlon
  end
end
