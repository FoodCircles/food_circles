class ExpiringSoonChecker

  def initialize
  end

  def check
    get_payments
    notify_users
  end

  private

  def get_payments
    @payments = Payment.active_payments.expiring_soon
  end

  def notify_users
    @payments.each do |payment|
      UserMailer.voucher_expiring_soon(payment.id).deliver
    end
  end

end