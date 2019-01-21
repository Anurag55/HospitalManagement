class PatientsController < ApplicationController

  filter_access_to :all

  def index

  end

  def new
      @patient=current_user.profile
      @patient=Patient.new
  end

  def create
    @user=current_user
    @user.profile = Patient.new(params[:patient])
    @patient = @user.profile
    if @patient.save
      flash[:notice] = "Created profile Successfully..."
      @user.update_profile
      redirect_to patients_path
    else
      flash[:notice] = "Unable to create profile,Try again..."
      redirect_to new_patient_path
    end
  end

  def edit
    @patient=Patient.find(params[:id])
  end

  def update
    @patient=Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      flash[:notice] = "Profile Successfully updated..."
    else
      flash[:notice] = "Profile could not updated, Try again..."
    end
    redirect_to :controller => "sessions", :action => "new"
  end


  def destroy
    @patient=Patient.find(params[:id])
    if @patient.destroy
      flash[:message] = "Patient deleted"
    else
      flash[:message] = "Cant destroy patient, Try again.."
    end
    redirect_to show_patients_admins_path
  end

  def show_profile
    @user=current_user
    @patient=@user.profile
  end

  def show_appointments
    @patient=current_user.profile
    @appointments=@patient.appointments
  end

  def get_appointments
      @department=Department.all
  end

  def show_slots
    @doctors= Department.find(params[:department][:id]).doctors
    date = Date.new params[:appointment]["date(1i)"].to_i, params[:appointment]["date(2i)"].to_i, params[:appointment]["date(3i)"].to_i
    if date >= Date.today
      @timeslots = Timeslot.all(:conditions => {:date => Date.civil(*params["appointment"].sort.map(&:last).map(&:to_i)), :doctor_id => @doctors.collect(&:id)})
    end
  end


  def create_appointment
    @user=current_user
    @slot=Slot.find(params[:id])
    @timeslot=@slot.timeslot
    @appointment= Appointment.new(:slot_id => params[:id], :time => @slot.time, :doctor_id => @slot.timeslot.doctor_id, :patient_id => @user.profile_id)
    if @appointment.save
      flash[:notice] = "Appointment taken Successfully..."
      redirect_to patients_path
    else
      flash[:notice] = "Appointment couldnt be taken, Try once again"
      redirect_to get_appointments_patients_path
    end
  end

end
