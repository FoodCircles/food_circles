class SocialbutterfliesController < ApplicationController
  def index
  	UserMailer.social_butterfly(params[:facebook]).deliver    	
  end 

end
