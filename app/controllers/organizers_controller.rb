class OrganizersController < ApplicationController
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
    UserMailer.organizers_notify(params[:email], params[:location], params[:address], params[:date], params[:num_people], params[:occassion], params[:budget], params[:food_preferences], params[:donation], params[:feedback]).deliver
    UserMailer.organizers_signup(params[:email]).deliver

    @n = Notification.create
    @n.content = "Email: #{params[:email]}, Location: #{params[:location]}, Address: #{params[:address]}, Date: #{params[:date]}, Number of People: #{params[:num_people]}, Occassion: #{params[:occassion]}, Budget: #{params[:budget]}, Food Preferences: #{params[:food_preferences]}, Donation: #{params[:donation]}, Feedback: #{params[:feedback]}"
    @n.ticker = "An organizers signup"
    @n.save
  end

  def valid_email?(email)
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ VALID_EMAIL_REGEX)
  end
end
