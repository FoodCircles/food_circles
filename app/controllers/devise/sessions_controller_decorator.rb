Devise::SessionsController.class_eval do
  after_filter :after_signin, :only=>:create

  def after_signin
    enqueue_mix_panel_event "Sign In"
  end
end
