# encoding: utf-8
require 'spec_helper'

describe UserMailer do

  it "voucher expiring soon" do
    Timecop.freeze(Time.new(2013, 11, 2, 11, 25)) do
      user = FactoryGirl.create(:user, :email => "test@test.com")
      venue = FactoryGirl.create(:venue, :name => "Mike's burgers", :phone => "983-143-1233")
      charity = FactoryGirl.create(:charity, :name => "Donate for life")
      offer = FactoryGirl.create(:offer, :name => "Extra fries", :venue_id => venue.id)
      payment = FactoryGirl.create(:payment, :user_id => user.id, :offer_id => offer.id, :charity_id => charity.id)

      UserMailer.voucher_expiring_soon(payment).deliver

      mail = ActionMailer::Base.deliveries.last
      mail['to'].to_s.should eq user.email

      mail.body.to_s.should eq <<MAIL_BODY
<html>
<head>

</head>
<body>
Hey
<br/>
<br/>
Your purchase for Extra fries at Mike&#x27;s burgers expires in 7 days
(12/02/13), and we just wanted to shoot you a reminder.
Your "Buy One, Feed One" special is, well, special.
It goes to feed   children through Donate for life and
our restaurant would love to thank you for your purchase.
<br/>
<br/>
Your original voucher is below. If you have any questions just let us know, and we hope you have an amazing time! 
<br/>
<br/>
“Philanthropists may urge what reforms they will, —less crowding, purer air better 
sanitary regulations: but this question of food underlies all.” -Helen Campbell
<br/>
<br/>
--
<br/>
<br/>
Good for: Extra fries
<br/>
Code: ADDJT
<br/>
<br/>
<br/>
Voucher expires in 30 days, on December  2, 2013.
<br/>
<br/>
Mike&#x27;s burgers - 983-143-1233
<br/>
<a href="http://maps.google.com?q=Mike%27s+burgers%2C+Ionia+Avenue+SW%2C+Grand+Rapids" target="_blank">Get Directions</a>
<br/>
<br/>
<br/>
Contact us at support@foodcircles.net.
<br/>
--
<br/>
REPLY "USED" ANYWHERE IN THE BODY OR SUBJECT TO MARK THIS VOUCHER AS USED
</body>
</html>
MAIL_BODY
    end
  end

end