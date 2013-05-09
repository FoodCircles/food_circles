class SocialbutterfliesController < ApplicationController
  def index
  	fb = params[:facebook]
    User_mailer.social_butterfly(fb).deliver
  end 
end
