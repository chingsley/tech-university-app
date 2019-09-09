class SessionsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create, :destroy]

  def new
  end

  def create
    student = Student.find_by(email: params[:sessions][:email].downcase)
    if student && student.authenticate(params[:sessions][:password])
      session[:student_id] = student.id
      flash[:success] = "Login successful. Welcome back"
      redirect_to student
    else
      flash.now[:notice] = "Incorrect email and/or password"
      render 'new'
    end
  end

  def destroy
    session[:student_id] = nil
    flash[:success] = "Logout successful!"
    redirect_to root_path
  end
end