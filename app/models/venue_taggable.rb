class VenueTaggable < ActiveRecord::Base
  belongs_to :venue_tag
  belongs_to :venue
end
