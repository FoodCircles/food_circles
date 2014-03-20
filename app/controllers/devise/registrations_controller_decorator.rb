Devise::RegistrationsController.class_eval do
  after_filter :after_signup, :only=>:create

  def after_signup
    if current_user
      enqueue_mix_panel_event "Sign Up"
      UserMailer.signupsuccess(current_user).deliver
    end
  end
end
