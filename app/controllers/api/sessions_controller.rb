class Api::SessionsController < ApplicationController
  before_filter :authenticate_user!, :only => [:update_profile]
  def sign_in
    begin
      @user = User.find_by_email(params[:user_email])
      if @user.nil?
        render :json => {:error => true, :description => "No params provided"}, status: 401 and return
      end
      if @user.valid_password?(params[:user_password])
        @auth_code = @user.authentication_token
      else
        render :json => {:error => true, :description => "Wrong password."}, status: 401 and return
      end
      render :json => {:error => false, :auth_token => "#{@auth_code}"}
    rescue Exception => e
      render :json => {:error => true, :description => "Internal Server Error."}, status: 503 and return
    end
  end

  def sign_up
    begin
      @user = User.new(email: params[:user_email], password: params[:user_password])
      if @user.save
        render :json => {:error => false, :description => "User saved."}
      else
        if !@user.errors.messages.empty?
          render :json => {:error => true, :description => "Error saving user.", :errors => @user.errors.messages}, status: 500 and return
        else
          render :json => {:error => true, :description => "Error saving user."}, status: 500 and return
        end
      end
    rescue Exception => e
      render :json => {:error => true, :description => "Internal Server Error."}, status: 503 and return
    end
  end

  def update_profile
    begin
      @user = User.find_by_authentication_token(params[:auth_token])
      if @user.update_attributes(params[:session])
        render :json => {:error => false, :description => "User saved."} and return
      else
        if !@user.errors.messages.empty?
          render :json => {:error => true, :description => "Error saving user.", :errors => @user.errors.messages}, status: 500 and return
        else
          render :json => {:error => true, :description => "Error saving user."}, status: 500 and return
        end
      end
    rescue Exception => e
      render :json => {:error => true, :description => "Internal Server Error."}, status: 503 and return
    end
  end
end
