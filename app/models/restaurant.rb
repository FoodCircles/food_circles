class Restaurant < ActiveRecord::Base
	attr_accessible :name, :email

	def new
		@restaurant = Restaurant.new
	end
end
