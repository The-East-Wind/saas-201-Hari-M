class DepartmentsController < ApplicationController
  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
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
