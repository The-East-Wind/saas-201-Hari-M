class DepartmentsController < ApplicationController
  before_action :authenticate_user!
  def index
    @departments = Department.all
  end

  def new
     unless current_user.admin?
    	flash[:danger] = "You are not allowed to access this page."
    	redirect_to root_path
     end

     @department = Department.new
  end


  def create
  	unless current_user.admin?
    		flash[:danger] = "You are not allowed to access this page."
    		redirect_to root_path
  	end

  	@department = Department.new(department_params)

  	if @department.save
    		redirect_to action: "index"
  	else
    		flash[:danger] = @department.errors.values.join(', ')
    		redirect_to action: "new"
  	end
   end

   private
   def department_params
    params[:department].permit(:name)
   end
end
