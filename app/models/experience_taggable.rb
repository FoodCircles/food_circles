class ExperienceTaggable < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :experience_tag
  belongs_to :venue
end