class OmniauthAskForEmailController < ApplicationController
  before_filter :verify
  def index
  end

  def submit
    current_user.email = params[:user][:email]
    if current_user.save
      redirect_to root_path
    else
      redirect_to :back, :alert => "There was an error (email #{current_user.errors.messages[:email].first})"
    end
  end
  
  def verify
    if authenticate_user!
      if !current_user.email.blank?
        redirect_to root_path
      end
    end
  end
end
