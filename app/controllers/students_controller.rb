class StudentsController < ApplicationController
  def create
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

    @notification = Notification.create
    @notification.content = "Email: #{email}"
    @notification.ticker = "A student leader signup"
    @notification.save
  end

  def valid_email?(email)
    valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    email.present? && (email =~ valid)
  end

end
