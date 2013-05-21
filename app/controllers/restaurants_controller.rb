class RestaurantsController < ApplicationController
  def index
    if(params[:email])
      if valid_email?(params[:email])
        signup
      else
        flash[:error] = 'Invalid email address.'
      end
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

  def valid_email?(email)
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ VALID_EMAIL_REGEX)
  end

end

