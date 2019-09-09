class StudentsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]
  before_action :set_student, only: [:show, :edit, :update] # Here order is paramount. If this 'set_student' before action is not above the the 'require_same_student' before action, then @student will be nil in the require_same_student method
  before_action :require_same_student, only: [:edit, :update]

  def index
    @students = Student.all
  end

  def show
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:success] = "You have successfully signed up"
      # redirect_to root_path
      redirect_to @student
    else
      render 'new'
    end
  end

  def update
    if @student.update(student_params)
      flash[:success] = "You have successfully updatated your profile"
      #redirect_to student_path(@student)
      redirect_to @student # This is a short form of the line immediately above
    else
      render 'edit'
    end
  end

  def edit
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end

  def require_same_student
    if current_user != @student
      redirect_to student_path(current_user)
      flash[:notice] = "You can only edit your own profile"
    end
  end

end