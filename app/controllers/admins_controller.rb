require 'wicked_pdf'
class AdminsController < ApplicationController

  filter_access_to :all

  def index

  end

  def show_patients
      @patients=Patient.all
  end

  def show_doctors
      @doctors=Doctor.all
      respond_to do |format|
        format.html
        format.pdf do
          render :pdf => "file"
        end
      end
  end

  def show_appointments
        @appointments=Appointment.all
  end

  def show_patientrecords
      @medical_records=MedicalRecord.all
  end

  def assign_beds_form
    @admit= Admit.new
  end

  def assign_beds
    @admit=Admit.create(params[:admit])
    redirect_to show_patientrecords_admins_path
  end

end
