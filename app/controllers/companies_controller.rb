class CompaniesController < ApplicationController
  def index
    if params[:email]
      signup
    end
  end

  def signup
    UserMailer.company_notify(params[:email], params[:name], params[:company]).deliver
    UserMailer.company_signup(params[:email], params[:name], params[:company]).deliver
  end
end
