class Api::GeneralController < ApplicationController
  def get_mailchimp_users
    
    begin
      gb = Gibbon::API.new
      number_of_users = gb.lists.list(:filters => {:list_name => Rails.configuration.mailchimp_list_name})["data"][0]["stats"]["member_count"]
      render :json => {:error => false, :content => number_of_users}
    rescue Timeout::Error => e
      render :json => {:error => true, :description => "Couldn't reach MailChimp in a timely fashion."}
    rescue Exception => e
      render :json => {:error => true, :description => "An unexpected error happened"}
    end
    
  end
end
