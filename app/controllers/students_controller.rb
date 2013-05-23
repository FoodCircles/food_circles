class StudentsController < ApplicationController

  def index
   	if(params[:students_email])
      if valid_email?(params[:students_email])
        signup
      else
        flash[:error] = 'Invalid email address.'
      end
    end
  end

  def signup
    email = params[:students_email]

    UserMailer.company_notify(email, name, company).deliver
    UserMailer.company_signup(email, name, company).deliver

    @n = Notification.create
    @n.content = "Email: #{email}"
    @n.ticker = "A student leader signup"
    @n.save
  end

  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid)
  end

end
