class StudentsController < ApplicationController
<<<<<<< HEAD
=======
  def index
    if params[:students_email]
      signup
    end
  end

  def signup
    UserMailer.students_notify(params[:students_email]).deliver
    UserMailer.students_signup(params[:students_email]).deliver
  end
>>>>>>> 5d69c31e3bbab8b34e3c25f00cfb83a158f4508e
end
