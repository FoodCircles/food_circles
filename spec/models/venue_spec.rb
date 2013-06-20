require "spec_helper"

describe Venue do
  before(:each) { build_user_data }

  describe "#with_display_offers" do
    context "when display offers are available" do
      it "loads offers with min diners equal to 2" do
        venues = Venue.with_display_offers
        venues.first.offers.first.min_diners.should == 2
      end
    end
  end
end