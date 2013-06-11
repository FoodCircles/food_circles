module TestHelper
  def build_user_data
    user = FactoryGirl.create(:user)
    venue = user.venues.create(FactoryGirl.attributes_for(:venue))
    offer = venue.offers.create(FactoryGirl.attributes_for(:offer))
  end
end