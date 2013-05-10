class RestaurantsController < ApplicationController
  def index
  	if params[:email]
  		signup
  	end
  end

  def signup
  	UserMailer.restaurant_notify(params[:email], params[:name]).deliver
  	UserMailer.restaurant_signup(params[:email], params[:name]).deliver
  end

end

