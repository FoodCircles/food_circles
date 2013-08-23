class PostcardsController < ApplicationController
  def create
    postcard = Postcard.create(params[:postcard])
    facebook_sharing_uri = URI.parse "http://www.facebook.com/sharer/sharer.php"

    # NOTE: If we ever host the assets somewhere else, this is going to break.
    # At that time, generate the url based on the asset host.
    image_path = ActionController::Base.helpers.asset_path("slide-01.jpg")
    image_url =  URI.join "http://staging.foodcicles.net", image_path
    
    query = {
      :s => 100,
      :p => {
        :url => restaurants_url,
        :images => [image_url.to_s],
        :title => "I want #{postcard.restaurant_name} to be a Buy One, Feed One restaurant",
        :summary => "Who's with me?"
      }
    }

    facebook_sharing_uri.query = query.to_query

    render :json => {
      :success => true,
      :description => "We'll be sending a snail mail postcard to #{postcard.restaurant_name} shortly",
      :facebook_sharing_uri => facebook_sharing_uri.to_s
    }
  end
end
