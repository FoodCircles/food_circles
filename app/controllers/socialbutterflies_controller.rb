class SocialbutterfliesController < ApplicationController
  def create
    UserMailer.social_butterfly(params[:facebook]).deliver
  end 
end
