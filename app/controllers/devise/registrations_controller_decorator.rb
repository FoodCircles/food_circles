Devise::RegistrationsController.class_eval do
	after_filter :after_signup, :only=>:create
	def after_signup
		UserMailer.signupsuccess(current_user)
	end
end
