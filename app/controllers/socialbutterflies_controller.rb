class SocialbutterfliesController < ApplicationController
  def index
    if params[:facebook]
      UserMailer.social_butterfly(params[:facebook]).deliver
    end
  end 
end
