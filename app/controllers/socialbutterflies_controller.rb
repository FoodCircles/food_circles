class SocialbutterfliesController < ApplicationController
  def index
  	
  end 

  def submit
  	#@socialbutterflies = Socialbutterflies.find(params[:facebook])
    UserMailer.social_butterfly("http://www.facebook.com/Siesna").deliver    	
  end

end
