class CharitiesController < ApplicationController
  def show
    @charity = Charity.find(params[:id])
    if ['json','jsonp'].include?(params[:format])
      render :json => @charity, :callback => params[:callback]
    end
  end
end
