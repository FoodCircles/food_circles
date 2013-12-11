class SmsVoucherSender

  TWILIO_SID = "ACc27c9d89875eabb1ab973353bf6c10f4"
  TWILIO_TOKEN = "38b05af540d55b26e856a2301cb2d943"
  TWILIO_PHONE_NUMBER = "4848213426"

  def initialize(phone, payment)
    @phone = phone
    @payment = payment
    @twilio_client = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
  end

  def send
    @twilio_client.account.sms.messages.create(
        :from => "+1#{TWILIO_PHONE_NUMBER}",
        :to => @phone,
        :body => "FoodCircles offer\nCode: #{@payment.code}\nItem:#{@payment.offer.name}\nAmount donated: $#{@payment.amount}\nVenue: #{@payment.offer.venue.name}"
    )
  end

end