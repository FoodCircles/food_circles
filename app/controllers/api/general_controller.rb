class Api::GeneralController < ApplicationController
  def get_mailchimp_users
    
    begin
      gb = Gibbon::API.new("d915933790ef85a69849f5c12a5162d7-us4")
      number_of_users = gb.lists.list(:filters => {:list_name => "FoodCircles Members"})["data"][0]["stats"]["member_count"]
      render :json => {:error => false, :content => number_of_users}
    rescue Timeout::Error => e
      render :json => {:error => true, :description => "Couldn't reach MailChimp in a timely fashion."}
    rescue Exception => e
      render :json => {:error => true, :description => "An unexpected error happened"}
    end
    
  end
end
