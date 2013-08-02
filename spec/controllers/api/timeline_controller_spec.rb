require 'spec_helper'

describe Api::TimelineController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

  describe "GET 'use_voucher'" do
    it "returns http success" do
      get 'use_voucher'
      response.should be_success
    end
  end

  describe "GET 'verify_payment_and_show_voucher'" do
    it "returns http success" do
      get 'verify_payment_and_show_voucher'
      response.should be_success
    end
  end

end
