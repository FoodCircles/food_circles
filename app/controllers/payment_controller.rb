class PaymentController < ApplicationController
  def index
  end

  def stripe
    @payment = Payment.new
  end
end
