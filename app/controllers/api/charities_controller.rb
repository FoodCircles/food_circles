class Api::CharitiesController < ApplicationController
  def show
    begin
      loc = request.location
      @charities = Charity.within_radius_of_location(loc.latitude, loc.longitude)
      @charities = @charities.empty? ? Charity.scoped : @charities
      @charities = @charities.active.all()
      return_arr = []
      @charities.each do |c|
        return_arr << {
          :id => c.id,
          :name => c.name,
          :description => c.description,
          :use_funds => c.use_funds
        }
      end

      render :json => {:error => false, :content => return_arr}
    rescue Exception => e
      render :json => {:error => true, :description => "Internal Server Error."}, status: 503 and return
    end
  end
end
