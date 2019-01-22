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
      render :new
    end
  end

  def edit
    @medical_record=MedicalRecord.find(params[:id])
  end

  def update
    @medical_record=MedicalRecord.find(params[:id])
    if @medical_record.update_attributes(params[:medical_record])
      flash[:notice] = "Medical Record Successfully updated..."
      redirect_to show_appointments_doctors_path
    else
      render :edit
    end
  end

end
