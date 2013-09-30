Devise::RegistrationsController.class_eval do
  after_filter :after_signup, :only=>:create

  def after_signup
    enqueue_mix_panel_event "Sign Up" if current_user
    UserMailer.signupsuccess(current_user)
  end
end
