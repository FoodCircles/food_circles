class PostcardsController < ApplicationController
  def create
    postcard = Postcard.new(params[:postcard])
    facebook_sharing_uri = URI.parse "http://www.facebook.com/sharer/sharer.php"
    twitter_sharing_uri = URI.parse "https://twitter.com/intent/tweet"

    image_url =  URI.join "http://#{request.host}", "assets/", "logo_old.png"
    
    facebook_query = {
      :s => 100,
      :p => {
        :url => restaurants_url,
        :images => {0 => image_url.to_s},
        :title => "I want #{postcard.restaurant_name} to be a Buy One, Feed One restaurant",
        :summary => "Who's with me?"
      }
    }

    twitter_query = {
      :text => "I want #{postcard.restaurant_name} to be a Buy One, Feed One restaurant. #BuyOneFeedOne",
      :url => restaurants_url
    }

    facebook_sharing_uri.query = facebook_query.to_query
    twitter_sharing_uri.query = twitter_query.to_query

    render :json => {
      :success => true,
      :description => "We'll be sending a snail mail postcard to #{postcard.restaurant_name} shortly",
      :facebook_sharing_uri => facebook_sharing_uri.to_s,
      :twitter_sharing_uri => twitter_sharing_uri.to_s
    }
  end
end
