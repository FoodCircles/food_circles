class PaymentDecorator < Draper::Decorator
  delegate_all

  def short_expiration_date
    expiring_at.strftime("%m/%d/%y")
  end

  def long_expiration_date
    expiring_at.strftime("%B %e, %Y")
  end

end
