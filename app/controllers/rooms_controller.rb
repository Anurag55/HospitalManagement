class RoomsController < ApplicationController
  filter_access_to :all
  
  before_filter :find_room,
        :only => [:show, :edit, :update, :destroy]


  def index
      @rooms=Room.all
      respond_to do |format|
        format.html
        format.csv {send_data Room.to_csv, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=Bed_availability_in_rooms.csv"}
      end
  end

  def show
  end

  def new
      @room=Room.new
  end

  def edit
  end

  def create
    @room=Room.new(params[:room])
    if @room.save
      redirect_to rooms_path
    else
      redirect_to new_room_path
    end
  end

  def update
    if @room.update_attributes(params[:room])
      redirect_to rooms_path
    else
      redirect_to edit_room_path
    end
  end

  def destroy
    if @room.destroy
      redirect_to rooms_path
    else
      redirect_to @room
    end
  end

  def find_room
    @room=Room.find(params[:id])
  end
end
