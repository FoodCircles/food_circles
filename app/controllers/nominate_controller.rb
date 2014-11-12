class NominateController < ApplicationController
  def index

  end

  def create


    UserMailer.nomination_notify(params[:email], params[:name], params[:contact], params[:story], params[:feedback]).deliver
    if valid_email?(params[:email])
      UserMailer.nomination_signup(params[:email]).deliver
    end

    @n = Notification.create
    @n.content = "Email: #{params[:email]}, Location: #{params[:name]}, Address: #{params[:contact]}, Date: #{params[:story]}, Number of People: #{params[:feedback]}"
    @n.ticker = "A nomination"
    @n.save

    @event = OpenStruct.new(params.except(:utf8, :authenticity_token))
    render 'confirm'
  end

  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid)
  end
end
