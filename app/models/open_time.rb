class OpenTime < ActiveRecord::Base
  belongs_to :openable, :polymorphic => true

  validates_presence_of :start,:end

  def as_json(options={})
    { :start => self.start,
      :end => self.end
    }
  end
end
