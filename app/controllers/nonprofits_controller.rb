class NonprofitsController < ApplicationController
  def index
    if params[:email]
      signup
    end
  end

  def signup
    UserMailer.nonprofits_notify(params[:email], params[:name], params[:organization], params[:website]).deliver
    UserMailer.nonprofits_signup(params[:email], params[:name]).deliver
  end
end
