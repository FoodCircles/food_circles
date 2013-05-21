class StudentsController < ApplicationController

  def index
    if params[:students_email]
      signup
    end
  end

  def signup
    UserMailer.students_notify(params[:students_email]).deliver
    UserMailer.students_signup(params[:students_email]).deliver
  end
end
