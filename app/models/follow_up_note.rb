class FollowUpNote < ActiveRecord::Base
  belongs_to :charity
  attr_accessible :note, :charity_id

  validates :note, presence: true


  rails_admin do
    edit do
      configure :note do
        html_attributes rows: 20, cols: 50
      end
    end
  end

end
