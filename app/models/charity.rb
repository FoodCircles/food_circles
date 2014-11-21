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

  def msg_usefunds(amt)
    uf = self.use_funds
    uf['%amt%'] = amt.to_s if uf.include? '%amt%'

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


end
