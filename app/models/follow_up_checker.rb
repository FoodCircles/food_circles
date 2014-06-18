class FollowUpChecker

  def initialize
  end

  def check
    get_payments
    notify_users
  end

  private

  def get_payments
    @payments = Payment.follow_up
  end

  def notify_users
    @payments.each do |payment|
      UserMailer.followup_email(payment).deliver
    end
  end

end