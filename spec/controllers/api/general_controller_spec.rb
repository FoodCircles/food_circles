require 'spec_helper'

describe Api::GeneralController do

  describe "GET 'get_mailchimp_users'" do
    it "returns http success" do
      get 'get_mailchimp_users'
      response.should be_success
    end
  end

end
