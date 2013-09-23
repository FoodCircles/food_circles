class OrganizersController < ApplicationController
  def create
    UserMailer.organizers_notify(params[:email], params[:location], params[:address], params[:date], params[:num_people], params[:occassion], params[:budget], params[:food_preferences], params[:donation], params[:feedback]).deliver
    if valid_email?(params[:email])
      UserMailer.organizers_signup(params[:email]).deliver
    end

    @n = Notification.create
    @n.content = "Email: #{params[:email]}, Location: #{params[:location]}, Address: #{params[:address]}, Date: #{params[:date]}, Number of People: #{params[:num_people]}, Occassion: #{params[:occassion]}, Budget: #{params[:budget]}, Food Preferences: #{params[:food_preferences]}, Donation: #{params[:donation]}, Feedback: #{params[:feedback]}"
    @n.ticker = "An organizers signup"
    @n.save

    @event = OpenStruct.new(params.except(:utf8, :authenticity_token))
    render 'confirm'
  end

  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid)
  end
end
