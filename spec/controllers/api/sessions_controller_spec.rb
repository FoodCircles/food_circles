require 'spec_helper'

describe Api::SessionsController do
  describe "POST 'sign_in'" do
    let(:user){ FactoryGirl.create :user }

    context "no params" do
      before(:each) do
        post 'sign_in'
      end

      it "fails without" do
        expect(response.status).to eq(401)
      end

      it "returns error response" do
        expect(response.body).to eq("{\"error\":true,\"description\":\"No params provided\"}")
      end
    end
    context "assigning an uid to a new user" do
      it "returns success" do
        post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        expect(response.status).to eq(200)
      end

      it "returns success body" do
        post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        u = User.last
        expect(response.body).to match(%r{{\"error\":false,\"description\":\"User saved\.\",\"auth_token\":\"#{u.authentication_token}\"}})
      end

      it "creates a new user" do
        expect{
          post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        }.to change{User.count}.by(1)
      end

      it "creates a new external uid" do
        expect{
          post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        }.to change{ExternalUID.count}.by(1)
      end

      it "the external uid belongs to the created user" do
        post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        u = User.last
        expect(u.external_uids.map(&:uid)).to include("123456")
      end
    end

    context "assigning to a new user an uid already belonging to another user" do
      before(:each) do
        post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
      end

      it "fails" do
        post 'sign_in', :user_email => "carlos@perez.com", :uid => "123456"
        expect(response.status).to eq(500)
      end

      it "returns error body" do
        post 'sign_in', :user_email => "carlos@perez.com", :uid => "123456"
        expect(response.body).to eq("{\"error\":true,\"description\":\"Error saving user\",\"errors\":{\"uid\":{\"uid\":[\"has already been taken\"]}}}")
      end

      it "does not create the new user" do
        expect{
          post 'sign_in', :user_email => "carlos@perez.com", :uid => "123456"
        }.to_not change{User.count}
      end

      it "does not create an external uid" do
        expect{
          post 'sign_in', :user_email => "carlos@perez.com", :uid => "123456"
        }.to_not change{ExternalUID.count}
      end
    end

    context "assigning an uid to an existing user" do
      it "returns success" do
        post 'sign_in', :user_email => user.email, :uid => "123456"
        expect(response.status).to eq(200)
      end

      it "returns success body" do
        post 'sign_in', :user_email => user.email, :uid => "123456"
        expect(response.body).to match(%r{{\"error\":false,\"description\":\"User retrieved\.\",\"auth_token\":\"#{user.authentication_token}\"}})
      end

      it "does not create a new user" do
        user
        expect{
          post 'sign_in', :user_email => user.email, :uid => "123456"
        }.to_not change{User.count}
      end

      it "creates a new external uid" do
        expect{
          post 'sign_in', :user_email => user.email, :uid => "123456"
        }.to change{ExternalUID.count}.by(1)
      end

      it "the external uid belongs to the user" do
        post 'sign_in', :user_email => user.email, :uid => "123456"
        user.reload
        expect(user.external_uids.map(&:uid)).to include("123456")
      end

      it "user can have many external uids" do
        post 'sign_in', :user_email => user.email, :uid => "123456"
        post 'sign_in', :user_email => user.email, :uid => "7891011"
        user.reload
        expect(user.external_uids.map(&:uid)).to include("123456")
        expect(user.external_uids.map(&:uid)).to include("7891011")
      end
    end

    context "assigning to an existing user an uid already belonging to another user" do
      before(:each) do
        post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
      end

      it "fails" do
        post 'sign_in', :user_email => user.email, :uid => "123456"
        expect(response.status).to eq(500)
      end

      it "returns error body" do
        post 'sign_in', :user_email => user.email, :uid => "123456"
        expect(response.body).to eq("{\"error\":true,\"description\":\"Error saving user\",\"errors\":{\"uid\":{\"uid\":[\"has already been taken\"]}}}")
      end

      it "does not create the new user" do
        user
        expect{
          post 'sign_in', :user_email => user.email, :uid => "123456"
        }.to_not change{User.count}
      end

      it "does not create an external uid" do
        expect{
          post 'sign_in', :user_email => user.email, :uid => "123456"
        }.to_not change{ExternalUID.count}
      end
    end

    context "uid owned by the provided user" do
      before(:each) do
        post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
      end

      it "success" do
        post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        expect(response.status).to eq(200)
      end

      it "returns success body" do
        post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        u = User.last
        expect(response.body).to match(%r{{\"error\":false,\"description\":\"User retrieved.\",\"auth_token\":\"#{u.authentication_token}\"}})
      end

      it "does not create the new user" do
        expect{
          post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        }.to_not change{User.count}
      end

      it "does not create an external uid" do
        expect{
          post 'sign_in', :user_email => "pepe@perez.com", :uid => "123456"
        }.to_not change{ExternalUID.count}
      end
    end

    context "sign in with valid uid" do
      before(:each) do
        post 'sign_in', :user_email => user.email, :uid => "123456"
      end

      it "returns success" do
        post 'sign_in', :uid => "123456"
        expect(response.status).to eq(200)
      end

      it "returns success body" do
        post 'sign_in', :uid => "123456"
        expect(response.body).to match(%r{{\"error\":false,\"description\":\"User retrieved\.\",\"auth_token\":\"#{user.authentication_token}\"}})
      end

      it "does not create a new user" do
        user
        expect{
          post 'sign_in', :uid => "123456"
        }.to_not change{User.count}
      end

      it "does not create a new external uid" do
        expect{
          post 'sign_in', :uid => "123456"
        }.to_not change{ExternalUID.count}.by(1)
      end
    end

    context "sign in with invalid uid" do
      it "returns failure" do
        post 'sign_in', :uid => "123456"
        expect(response.status).to eq(401)
      end

      it "returns success body" do
        post 'sign_in', :uid => "123456"
        expect(response.body).to match("{\"error\":true,\"description\":\"Wrong uid\.\"}")
      end

      it "does not create a new user" do
        user
        expect{
          post 'sign_in', :uid => "123456"
        }.to_not change{User.count}
      end

      it "does not create a new external uid" do
        expect{
          post 'sign_in', :uid => "123456"
        }.to_not change{ExternalUID.count}.by(1)
      end
    end
  end

  describe "GET 'sign_in'" do
    it "returns http success" do
      pending
    end
  end

  describe "GET 'sign_up'" do
    it "returns http success" do
      pending
    end
  end

  describe "GET 'update_profile'" do
    it "returns http success" do
      pending
    end
  end

end
