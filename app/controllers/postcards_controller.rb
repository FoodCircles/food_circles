class PostcardsController < ApplicationController
  def create
    postcard = Postcard.new(params[:postcard])
    render :json => {
      :success => true,
      :description => "We'll be sending a snail mail postcard to #{postcard.restaurant_name} shortly",
      :facebook_sharing_uri => view_context.facebook_share_url("I want #{postcard.restaurant_name} to be a Buy One, Feed One restaurant", "Who's with me?"),
      :twitter_sharing_uri => view_context.twitter_share_url("I want #{postcard.restaurant_name} to be a Buy One, Feed One restaurant. #BuyOneFeedOne")
    }
  end
end
