class OrganizersController < ApplicationController
  def index
    if params[:email]
      signup
    end
  end

  def signup
    UserMailer.organizers_notify(params[:email], params[:location], params[:address], params[:date], params[:num_people], params[:occassion], params[:budget], params[:food_preferences], params[:donation], params[:feedback]).deliver
    UserMailer.organizers_signup(params[:email]).deliver
  end
end
