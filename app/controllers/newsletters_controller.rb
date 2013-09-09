class NewslettersController < ApplicationController

  # TODO: display the errors and messages somewhere on the page
  def subscribe
    begin
      result = if current_user || params[:email].present?
        gb = Gibbon::API.new
        list_id = gb.lists.list(:filters => {:list_name => Rails.configuration.mailchimp_list_name})["data"][0]["id"]
        api_result = gb.lists.subscribe({:id => list_id, :email => {:email => current_user ? current_user.email : params[:email]}, :merge_vars => {:FNAME => current_user ? current_user.name : params[:email], :LNAME => ''}, :double_optin => false})
        if api_result["errors"].present?
          partial = current_user ? 'user_subscription_error' : 'subscription_error'
          {:error => true, :description => api_result["errors"].map{|error| error["error"]}.to_sentence}
        else
          partial = current_user ? 'user_subscription_success' : 'subscription_success'
          {:success => true, :description => "You've subscribed to our list. You'll soon receive an email to confirm your subscription."}
        end
      else
        partial = 'subscription_error'
        {:error => true, :description => "You need to sign up"}
      end
      respond_to do |format|
        format.json { render :json => result }
        format.js   { render partial: partial }
      end
    rescue Timeout::Error => e
      render :json => {:error => true, :description => "Couldn't reach MailChimp in a timely fashion."}
    end
  end
end
