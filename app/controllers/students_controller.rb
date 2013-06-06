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

    UserMailer.students_notify(email).deliver
    UserMailer.students_signup(email).deliver

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
