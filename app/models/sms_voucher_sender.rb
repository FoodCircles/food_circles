class SmsVoucherSender

  TWILIO_SID = "AC085df9dc6444a3588933ae0ddd9d95e7"
  TWILIO_TOKEN = "95cc7f360064ab606017dad6d2eb38a5"
  TWILIO_PHONE_NUMBER = "4422223663"

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