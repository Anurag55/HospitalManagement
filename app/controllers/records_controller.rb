class RecordsController < ApplicationController
  filter_access_to :all

  def new
    @admit=Admit.find(params[:id])
    @record=Record.new
  end

  def create
    @record= Record.new(params[:record])
    if @record.save
      flash[:notice] = "Patient discharged..."
      redirect_to admins_path
    else
      flash[:notice] = "Can't discharge patient.Try again..."
      redirect_to discharge_patient_form_admits_path
    end


  end
end
