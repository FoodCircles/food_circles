class PostcardsController < ApplicationController
  def create
    postcard = Postcard.create(params[:postcard])
    
    render :json => {:success => true, :description => "We'll be sending a snail mail postcard to #{postcard.restaurant_name} shortly"}
  end
end