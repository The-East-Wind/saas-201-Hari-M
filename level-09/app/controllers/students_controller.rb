class StudentsController < ApplicationController
	before_action :authenticate_user!
	def index
	    if params[:department_id]&&params[:section_id]
	      @students = Student.where({department_id: params[:department_id],section_id: params[:section_id]}).all
	    elsif params[:department_id]
			@students = Student.where(department_id: params[:department_id]).all
	    elsif params[:section_id]
			@students = Student.where(section_id: params[:section_id]).all
	    else 	
	      @students = Student.all
	    end
	end

	  def new
	    
	    unless current_user.admin?
    		flash[:danger] = "You are not allowed to access this page."
    		redirect_to root_path
     	    end

	    @student = Student.new
	    @section_collection = Section.all.collect { |p| [p.name, p.id]}
	    @department_collection = Department.all.collect { |p| [p.name, p.id] }
	  end

	  def create
	    
	    unless current_user.admin?
    		flash[:danger] = "You are not allowed to access this page."
    		redirect_to root_path
  	    end
	    
	    @student = Student.new(student_params)
	    if @student.save
	      	redirect_to action: "index"
	    else
	      	flash[:danger] = @student.errors.values.join(', ')
    		redirect_to action: "new"
	    end
	  end

	  def show
	    @students = Student.find(params[:id])
	    @sections = Section.find(@students.section_id)
	    @departments = Department.find(@students.department_id)	
	  end

	  private

	  def student_params
	    params[:student].permit(:name, :section_id, :department_id, :student_id, :email, :roll_no)
	  end
end
