class VenueTag < ActiveRecord::Base
  has_many :venue_taggables
  has_many :venues, :through => :venue_taggables

  def as_json(options={})
    { :id => self.id,
      :name => self.name
    }
  end
end
