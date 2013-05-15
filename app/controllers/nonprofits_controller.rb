class NonprofitsController < ApplicationController
  def index
    if params[:email]
      signup
    end

  def signup
    UserMailer.nonprofits_notify(params[:email], params[:name], params[:organization], params[:we_solve]).deliver
    UserMailer.nonprofits_signup(params[:email], params[:name], params[:organization], params[:we_solve]).deliver
  end
end
