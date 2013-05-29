class NonprofitsController < ApplicationController
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
    name = params[:name]
    email = params[:email]
    company = params[:organization]
    website = params[:website]

    UserMailer.nonprofits_notify(params[:email], params[:name], params[:organization], params[:website]).deliver
    UserMailer.nonprofits_signup(params[:email], params[:name]).deliver

    @n = Notification.create
    @n.content = "Name: #{name}, Organization: #{organization}, Email: #{email}, Website: #{website}"
    @n.ticker = "A nonprofits signup"
    @n.save
  end

  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid)
  end
end
