class PatientsController < ApplicationController

  filter_access_to :all
  before_filter :find_patient,
        :only => [:edit, :update, :destroy]

  def index

  end

  def new
      @patient=current_user.profile
      @patient=Patient.new
  end

  def create
    @patient = Patient.new(params[:patient])
    if @patient.save
      flash[:notice] = "Created profile Successfully..."
      current_user.update_profile @patient
      redirect_to patients_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @patient.update_attributes(params[:patient])
      flash[:notice] = "Profile Successfully updated..."
      redirect_to :controller => "sessions", :action => "new"
    else
      render :edit
    end
  end


  def destroy
    if @patient.destroy
      flash[:message] = "Patient deleted"
    else
      flash[:message] = "Cant destroy patient, Try again.."
    end
    redirect_to show_patients_admins_path
  end

  def show_profile
    @patient = current_user.profile
  end

  def show_appointments
    @patient = current_user.profile
    @appointments = @patient.appointments
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
    @slot=Slot.find(params[:id])
    @appointment= Appointment.new(:slot_id => params[:id], :time => @slot.time, :doctor_id => @slot.timeslot.doctor_id, :patient_id => current_user.profile_id)
    if @appointment.save
      flash[:notice] = "Appointment taken Successfully..."
      redirect_to patients_path
    else
      flash[:notice] = "Appointment couldnt be taken, Try once again"
      redirect_to get_appointments_patients_path
    end
  end

  def find_patient
    @patient=Patient.find(params[:id])
  end

end
