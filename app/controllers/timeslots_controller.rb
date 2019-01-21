class TimeslotsController < ApplicationController

  filter_access_to :all

  def index
    @timeslots=Timeslot.all

  end

  def new
    @department=Department.all
    @timeslot=Timeslot.new

  end

  def create
    @timeslot= Timeslot.new(params[:timeslot])
    if @timeslot.update_attributes(:date => @timeslot.start_time.to_date)
      @timeslot.generate_slots
      flash[:notice] = "Timeslot Successfully created..."
      redirect_to timeslots_path
    else
      flash[:notice] = "Unable to create timeslots, Select valid datetime"
      redirect_to new_timeslot_path
    end

  end

  def show
    @timeslot=Timeslot.find(params[:id])
    @slots=@timeslot.slots
  end


  def list_doctors
    @available_doctors= Department.find(params[:department_id]).doctors
    @timeslot=Timeslot.new
    render :update do |page|
      page.replace_html 'available_doctors' ,:partial =>'available_doctors'
    end
  end



end
