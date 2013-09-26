class CompaniesController < ApplicationController
  def index
    enqueue_mix_panel_event "Visits Companies Get Involved Sub Page"
  end

  def create
    enqueue_mix_panel_event "Submits Companies Get Involved Form"

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

    @notification = Notification.create
    @notification.content = "Name: #{name}, Company: #{company} Email: #{email}"
    @notification.ticker = "A company signup"
    @notification.save
  end

  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid)
  end
end
