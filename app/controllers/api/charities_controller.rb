class Api::CharitiesController < ApplicationController
  def show
    begin
      @charities = Charity.active.all() 
      return_arr = []
      @charities.each do |c|
        return_arr << {
          :id => c.id,
          :name => c.name,
          :description => c.description,
          :use_of_funds => nil
        }
      end

      render :json => {:error => false, :content => return_arr}
    rescue Exception => e
      render :json => {:error => true, :description => "Internal Server Error."}, status: 503 and return
    end
  end
end
