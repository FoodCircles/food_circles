class Reservation < ActiveRecord::Base
  belongs_to :charity
  belongs_to :offer
  belongs_to :user
  belongs_to :venue

  def as_json(options={})
    { :id => self.id,
      :coupon => self.coupon,
      :name => self.name,
      :success => true
    }
  end

  def self.weekly_update


    auto_emails = Reservation.all(:select => "created_at");

    UserMailer.weekly_mail().deliver

  end

end
