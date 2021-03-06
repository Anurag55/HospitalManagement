class AdmitsController < ApplicationController

  filter_access_to :all

  def index
  end

  def new
    @rooms=Room.all
    @medicalrecord= MedicalRecord.find(params[:record_id])
  end

  def create
    @medical_record = MedicalRecord.find(params[:record_id])
    @admit= Admit.new(:date => params[:date], :time => params[:time], :bed_id => params[:admit][:bed_id], :appointment_id => @medical_record.appointment_id)
    if @admit.save
      flash[:notice] = "Patient Successfully admitted..."
      redirect_to show_patientrecords_admins_path
    else
      render :new
    end
  end

  def discharge_patient_form
    @admits=Admit.all(:conditions => { :is_discharged => 0 })

  end

  def list_beds
    @available_beds= Bed.all(:conditions => { :room_id => params[:room_id], :is_allocated => 0 })
    @admit=Admit.new
    render :update do |page|
      page.replace_html 'available_beds' ,:partial =>'available_beds'
    end
  end


end
