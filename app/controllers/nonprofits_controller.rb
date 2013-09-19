class NonprofitsController < ApplicationController
  def create
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
    organization = params[:organization]
    website = params[:website]
    from_grand_rapids = params[:from_grand_rapids].present?

    UserMailer.nonprofits_notify(email, name, organization, website, from_grand_rapids).deliver
    UserMailer.nonprofits_signup(email, name).deliver

    @notification = Notification.create
    @notification.content = "Name: #{name}, Organization: #{organization}, Email: #{email}, Website: #{website}"
    @notification.ticker = "A nonprofits signup"
    @notification.save
  end

  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid)
  end
end
