class SocialbutterfliesController < ApplicationController
  def index
    enqueue_mix_panel_event "Visits Social Butterflies Get Involved Sub Page"
  end

  def create
    enqueue_mix_panel_event "Submits Social Butterflies Get Involved Form"
    UserMailer.social_butterfly(params[:facebook]).deliver
  end 
end
