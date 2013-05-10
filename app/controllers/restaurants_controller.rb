class RestaurantsController < ApplicationController
  def index
  	if params[:email]
  		signup
  	end
  end

  def signup
  	email = params[:email]
  	name = params[:name]
  	UserMailer.restaurant_notify(email, name).deliver
  	UserMailer.restaurant_signup(email, name).deliver

  	@n = Notification.create
	@n.content = "Name: #{name}, Email: #{email}"
	@n.ticker = "A restaurant signup"
	@n.save
  end

end

