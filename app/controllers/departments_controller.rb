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
      render :new
    end
  end

  def destroy
    @department=Department.find(params[:id])
    if @department.destroy
      flash[:notice] = "Deartment deleted"
    else
      flash[:notice] = "Couldnt delete department, Try again..."
    end
    redirect_to departments_path
  end

end
