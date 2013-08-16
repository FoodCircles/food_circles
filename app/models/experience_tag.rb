class ExperienceTag < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :experience_taggables
  has_many :venues, :through => :experience_taggables

  def as_json(options={})
    { :id => self.id,
      :name => self.name
    }
  end
end
