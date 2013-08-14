class NewslettersController < ApplicationController

  # TODO: display the errors and messages somewhere on the page
  def subscribe
    begin
      result = if current_user
        gb = Gibbon::API.new
        list_id = gb.lists.list(:filters => {:list_name => Rails.configuration.mailchimp_list_name})["data"][0]["id"]
        
        api_result = gb.lists.batch_subscribe(:id => list_id, :batch => [{:email => {:email => current_user.email}}])
        if api_result["errors"].any?
          {:error => true, :description => api_result["errors"].map{|error| error["error"]}.to_sentence}
        else
          {:success => true, :description => "You've subscribed to our list. You'll soon receive an email to confirm your subscription."}
        end
      else
        {:error => true, :description => "You need to sign up"}
      end
      render :json => result
    rescue Timeout::Error => e
      render :json => {:error => true, :description => "Couldn't reach MailChimp in a timely fashion."}
    end
  end
end
