require 'spec_helper'

describe Api::SessionsController do

  describe "GET 'sign_in'" do
    it "returns http success" do
      get 'sign_in'
      response.should be_success
    end
  end

  describe "GET 'sign_up'" do
    it "returns http success" do
      get 'sign_up'
      response.should be_success
    end
  end

  describe "GET 'update_profile'" do
    it "returns http success" do
      get 'update_profile'
      response.should be_success
    end
  end

end
