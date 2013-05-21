class CompaniesController < ApplicationController
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
    company = params[:company]

    UserMailer.company_notify(email, name, company).deliver
    UserMailer.company_signup(email, name, company).deliver

    @n = Notification.create
    @n.content = "Name: #{name}, Company: #{company} Email: #{email}"
    @n.ticker = "A company signup"
    @n.save
  end

  def valid_email?(email)
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ VALID_EMAIL_REGEX)
  end

end
