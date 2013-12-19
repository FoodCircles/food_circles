class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    if current_user.nil?
      @user = User.find_by_facebook_uid(request.env["omniauth.auth"].uid)
      if @user.nil?
        @user = User.find_by_email(request.env["omniauth.auth"].info.email)

        if @user.nil?
          @user = User.new(name: request.env["omniauth.auth"].info.name,
                           provider: request.env["omniauth.auth"].provider,
                           email: request.env["omniauth.auth"].info.email,
                           facebook_uid: request.env["omniauth.auth"].uid,
                           facebook_secret: request.env["omniauth.auth"]["credentials"].secret,
                           facebook_token: request.env["omniauth.auth"]["credentials"].token,
                           has_facebook: true
          )
          enqueue_mix_panel_event "Facebook Sign Up"
        else
          @user.facebook_uid = request.env["omniauth.auth"].uid
          @user.facebook_secret=request.env["omniauth.auth"]["credentials"].secret
          @user.facebook_token=request.env["omniauth.auth"]["credentials"].token
          @user.has_facebook=true
          enqueue_mix_panel_event "Facebook Sign In"
        end

      else
        enqueue_mix_panel_event "Facebook Sign In"
      end

      @user.do_password_validation = false
      @user.save
      sign_in_and_redirect @user
    else
      current_user.facebook_secret = request.env["omniauth.auth"]["credentials"].secret
      current_user.facebook_token = request.env["omniauth.auth"]["credentials"].token
      current_user.has_facebook = true
      current_user.save
      redirect_to root_path
    end
  end

  def twitter
    if current_user.nil?

      @user = User.find_by_twitter_uid(request.env["omniauth.auth"].uid)
      if @user.nil?
        @user = User.new(name: request.env["omniauth.auth"].info.name,
                         provider: request.env["omniauth.auth"].provider,
                         email: "",
                         twitter_uid: request.env["omniauth.auth"].uid,
                         twitter_secret: request.env["omniauth.auth"]["credentials"].secret,
                         twitter_token: request.env["omniauth.auth"]["credentials"].token,
                         has_twitter: true
        )
        enqueue_mix_panel_event "Twitter Sign Up"
      else
        enqueue_mix_panel_event "Twitter Sign In"
      end

      @user.do_password_validation = false
      @user.save

      sign_in_and_redirect @user
    else
      current_user.twitter_secret = request.env["omniauth.auth"]["credentials"].secret
      current_user.twitter_token = request.env["omniauth.auth"]["credentials"].token
      current_user.has_twitter = true
      current_user.save
      redirect_to root_path
    end
  end

end
