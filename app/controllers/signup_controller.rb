class SignupController < ApplicationController
  def index
    enqueue_mix_panel_event "Visits Signup Sub Page"
  end

  def create
    enqueue_mix_panel_event "Submits Signup Form"
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

    @notification = Notification.create
    @notification.content = "Name: #{name}, Email: #{email}"
    @notification.ticker = "A restaurant signup"
    @notification.save
  end

  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid)
  end
end
