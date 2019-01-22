class BedsController < ApplicationController

  filter_access_to :all
  before_filter :find_room,
        :only => [:new, :create, :edit, :update, :destroy]

  def index

  end

  def new
    @bed=@room.beds.build
  end

  def create
    @room=Room.find(params[:room_id])
    @bed=@room.beds.build(params[:bed])
    if @bed.save
      flash[:notice]= "bed created"
      redirect_to @room
    else
      render :action => "new"
    end

  end

  def show
    @bed=Bed.find(params[:id])
    @room=@bed.room
    @admit= Admit.first(:conditions => { :bed_id => @bed.id, :is_discharged => 0 })
    @appointment= Appointment.find(@admit.appointment_id)
    @patient= Patient.find(@appointment.patient_id)

  end

  def edit
    @bed = @room.beds.find(params[:id])
  end

  def update
    @bed = Bed.find(params[:id])
    if @bed.update_attributes(params[:bed])
      redirect_to @room
      flash[:notice] = "Bed updated Successfully..."
    else
      render :edit
    end
  end

  def destroy
    @bed = Bed.find(params[:id])
    if @bed.destroy
      flash[:notice] = "Bed deleted Successfully..."
    else
      flash[:notice] = "Bed couldnt deleted, Try again..."
    end
    redirect_to @room
  end

  def find_room
    @room=Room.find(params[:room_id])
  end

end
