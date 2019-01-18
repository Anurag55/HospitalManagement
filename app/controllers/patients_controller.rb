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
    @patient=Patient.find(current_user.profile_id)
  end

  def update
    @patient=Patient.find(current_user.profile_id)
    if @patient.update_attributes(params[:patient])
      flash[:notice] = "Profile Successfully updated..."
    else
      flash[:notice] = "Profile could not updated, Try again..."
    end
    redirect_to show_profile_patients_path
  end

  def show_profile
    @patient=current_user.profile
  end

  def show_appointments

  end

  def get_appointments
      @department=Department.all
  end

  def show_slots
    @doctors= Doctor.all(:conditions => {:department_id => params[:department][:id]})
    date=params["post"]["date"]
    @timeslots = Timeslot.all(:conditions => {:date => Date.civil(*params["post"].sort.map(&:last).map(&:to_i)), :doctor_id => @doctors.collect(&:id)})
  end


  def create_appointment
    @user=current_user
    @slot=Slot.find(params[:id])
    @timeslot=@slot.timeslot
    @appointment= Appointment.new(:slot_id => params[:id], :time => params[:time], :doctor_id => @slot.timeslot.doctor_id, :patient_id => @user.profile_id)
    if @appointment.save
      UserMailer.deliver_appointment_email(@user,@appointment)
      flash[:notice] = "Appointment taken Successfully..."
      redirect_to patients_path
    else
      flash[:notice] = "Appointment couldnt be taken, Try once again"
      redirect_to get_appointments_patients_path
    end
  end

end
