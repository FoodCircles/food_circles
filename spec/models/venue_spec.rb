require "spec_helper"

describe Venue do
  describe "#with_display_offers" do
    before(:each) { build_user_data }

    context "when display offers are available" do
      it "loads offers with min diners equal to 2" do
        venues = Venue.with_display_offers
        venues.first.offers.first.min_diners.should == 2
      end
    end
  end

  describe "#watching users" do
    let(:user){ FactoryGirl.create :user }
    let(:venue){ FactoryGirl.create :venue }

    it "should add watching users" do
      expect{venue.watching_users << user}.to change{NotificationRequest.count}.by(1)
      venue.reload

      expect(venue.watching_users).to include user
      expect(user.watched_venues).to include venue
    end

    it "should email watching users when a watched venue has new vouchers" do
      venue.watching_users << user

      mail = double("mail")
      UserMailer.should_receive(:notification_about_available_vouchers).with(user, venue).once.and_return(mail)
      mail.should_receive(:deliver).once

      venue.vouchers_available += 10
      venue.save!
    end

    it "should not email watching users when a watched venue has less vouchers" do
      venue.watching_users << user

      UserMailer.should_not_receive(:notification_about_available_vouchers)

      venue.vouchers_available -= 5
      venue.save!
    end

    it "should not email watching users when a watched venue has some irrelevant update" do
      venue.watching_users << user

      UserMailer.should_not_receive(:notification_about_available_vouchers)

      venue.name = "whatever"
      venue.save!
    end
  end
end
