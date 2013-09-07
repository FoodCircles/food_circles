class NewslettersController < ApplicationController

  # TODO: display the errors and messages somewhere on the page
  def subscribe
    Rails.logger.debug("debug:: subscribing" + params[:email] || 'no email')
    begin
      result = if current_user || params[:email].present?
        gb = Gibbon::API.new
        list_id = gb.lists.list(:filters => {:list_name => Rails.configuration.mailchimp_list_name})["data"][0]["id"]
        api_result = gb.lists.batch_subscribe(:id => list_id, :batch => [{:email => {:email => current_user ? current_user.email : params[:email]}}])
        if api_result["errors"].any?
          {:error => true, :description => api_result["errors"].map{|error| error["error"]}.to_sentence}
          partial = current_user ? 'user_subscription_error' : 'subscription_error'
        else
          {:success => true, :description => "You've subscribed to our list. You'll soon receive an email to confirm your subscription."}
          partial = current_user ? 'user_subscription_success' : 'subscription_success'
        end
      else
        {:error => true, :description => "You need to sign up"}
        partial = 'subscription_error'
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
