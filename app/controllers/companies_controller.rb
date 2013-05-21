class CompaniesController < ApplicationController
  def index
  	if(params[:email])
    #if valid_email?(params[:email])
      signup
    #else
    #  flash[:error] = 'Invalid email address.'
    end
  end

  def signup
    UserMailer.company_notify(params[:email], params[:name], params[:company]).deliver
    UserMailer.company_signup(params[:email], params[:name], params[:company]).deliver
  end
end
