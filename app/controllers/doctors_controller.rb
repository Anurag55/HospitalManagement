class DoctorsController < ApplicationController

  filter_access_to :all
  before_filter :find_doctor,
        :only => [:edit, :update, :destroy]

  def index
  end

  def new
      @doctor=Doctor.new
  end

  def create
    @doctor = Doctor.new(params[:doctor])
    if @doctor.save
      flash[:notice] = "Created profile Successfully..."
      current_user.update_profile @doctor
      redirect_to doctors_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @doctor.update_attributes(params[:doctor])
      flash[:notice] = "Profile Successfully updated..."
      redirect_to :controller => "sessions", :action => "new"
    else
      render :edit
    end
  end

  def destroy
    if @doctor.destroy
      flash[:message] = "Doctor deleted"
    else
      flash[:message] = "Cant destroy doctor, Try again.."
    end
    redirect_to show_doctors_admins_path
  end

  def show_profile
    @doctor=current_user.profile
  end

  def show_appointments
      @doctor=current_user.profile
      @appointments=@doctor.appointments
  end

  def show_patients
      @patients=current_user.profile.patients
  end

  def show_timeslots
      @timeslots=current_user.profile.timeslots
  end

  def show_slots
    @timeslot=Timeslot.find(params[:id])
    @slots=@timeslot.slots
  end
  
  private
  def find_doctor
    @doctor=Doctor.find(params[:id])
  end
end
