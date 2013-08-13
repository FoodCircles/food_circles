require "spec_helper"

describe User do
  let(:user) {FactoryGirl.create :user}
  let(:venue) {FactoryGirl.create :venue}

  it "should add watched_venues" do
    expect{user.watched_venues << venue}.to change{NotificationRequest.count}.by(1)
    user.reload
    venue.reload

    expect(venue.watching_users).to include user
    expect(user.watched_venues).to include venue
  end
end
