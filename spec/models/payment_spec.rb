require 'spec_helper'

describe Payment do

  it "active payments" do
    payment1 = FactoryGirl.create(:payment, :state => nil)
    payment2 = FactoryGirl.create(:payment, :state => 'Active')
    FactoryGirl.create(:payment, :state => 'Used')
    FactoryGirl.create(:payment, :state => 'Expired')

    Payment.active_payments.should eq [payment1, payment2]
  end

  it "expiring soon" do
    Timecop.freeze(DateTime.new(2013,12,1,0,0,1)) do
      payment1 = FactoryGirl.create(:payment, :created_at => 25.days.ago)
      payment2 = FactoryGirl.create(:payment, :created_at => 21.days.ago)
      payment3 = FactoryGirl.create(:payment, :created_at => 23.days.ago + 1.hour)
      payment4 = FactoryGirl.create(:payment, :created_at => 23.days.ago + 23.hours)

      Payment.expiring_soon.should eq [payment3, payment4]
    end
  end

  it "expiring at" do
    Timecop.freeze do
      payment1 =  FactoryGirl.create(:payment)
      payment1.expiring_at.should eq 30.days.from_now
    end
  end

end