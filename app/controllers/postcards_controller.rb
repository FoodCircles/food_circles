class PostcardsController < ApplicationController
  def create
    postcard = Postcard.create(params[:postcard])
    facebook_sharing_uri = URI.parse "http://www.facebook.com/sharer/sharer.php"

    image_url =  URI.join "http://#{request.host}", "assets/", "logo_old.png"
    
    query = {
      :s => 100,
      :p => {
        :url => restaurants_url,
        :images => {0 => image_url.to_s},
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
