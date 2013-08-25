module HomeHelper
  def show_newsletter_subscription_button?
    return false unless current_user
    gb = Gibbon::API.new
    list_id = gb.lists.list(:filters => {:list_name => Rails.configuration.mailchimp_list_name})["data"][0]["id"]
    api_result = gb.lists.member_info(:id => list_id, :emails => [{:email => current_user.email}])
    return true if api_result["errors"].any?
    false
  rescue Timeout::Error => e
    false
  end
end
