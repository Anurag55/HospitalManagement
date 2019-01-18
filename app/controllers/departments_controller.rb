class DepartmentsController < ApplicationController

  filter_access_to :all

  def index
      @departments = Department.all
    end

  def new
      @department = Department.new
  end

  def create
    @department = Department.new(params[:department])
    if @department.save
      flash[:notice] = "Department created..."
      redirect_to departments_path
    else
      flash[:notice] = "Unable to create department, Try again..."
      redirect_to new_departments_path
    end
  end

  
end
