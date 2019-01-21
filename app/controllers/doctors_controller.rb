class DoctorsController < ApplicationController

  filter_access_to :all

  def index


  end

  def new
      @doctor=Doctor.new
  end

  def create
    @user=current_user
    @user.profile = Doctor.new(params[:doctor])
    @doctor = @user.profile
    if @doctor.save
      flash[:notice] = "Created profile Successfully..."
      @user.update_profile
      redirect_to doctors_path
    else
      flash[:notice] = "Unable to create profile,Try again..."
      redirect_to new_doctor_path
    end
  end

  def edit
    @doctor=Doctor.find(params[:id])
  end

  def update
    @doctor=Doctor.find(params[:id])
    if @doctor.update_attributes(params[:doctor])
      flash[:notice] = "Profile Successfully updated..."
    else
      flash[:notice] = "Profile could not updated, Try again..."
    end
    redirect_to :controller => "sessions", :action => "new"
  end

  def destroy
    @doctor=Doctor.find(params[:id])
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

end
