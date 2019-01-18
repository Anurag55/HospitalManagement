class MedicalRecordsController < ApplicationController

  filter_access_to :all

  def index
  end

  def new
    @appointment=Appointment.find(params[:id])
    @medical_record=MedicalRecord.new
  end

  def create
    @medical_record=MedicalRecord.new(params[:medical_record])
    if @medical_record.save
      flash[:notice] = "Medical record of respective patent created Successfully..."
      redirect_to show_appointments_doctors_path
    else
      flash[:notice] = "Unable to create Medical record of respective patient, Try again..."
      redirect_to new_medical_record_path
    end

  end

  def edit
    @medical_record=MedicalRecord.find(params[:id])
  end

  def update
    @medical_record=MedicalRecord.find(params[:id])
    if @medical_record.update_attributes(params[:medical_record])
      flash[:notice] = "Medical Record Successfully updated..."
    else
      flash[:notice] = "Unable to update Medical Record,Try again..."
    end
    redirect_to show_appointments_doctors_path
  end

end
