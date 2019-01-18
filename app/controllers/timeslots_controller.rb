class TimeslotsController < ApplicationController

  filter_access_to :all

  def index
    @timeslots=Timeslot.all

  end

  def new
    @department=Department.all
    @timeslot=Timeslot.new

  end

  def create#TODO
    @timeslot= Timeslot.new(params[:timeslot])
    if @timeslot.update_attributes(:date => @timeslot.start_time.to_date)
      @timeslot.generate_slots
      flash[:notice] = "Timeslot Successfully created..."
      redirect_to timeslots_path
    else
      flash[:notice] = "Unable to create timeslots"
      redirect_to new_timeslot_path
    end

  end

  def show
    @timeslot=Timeslot.find(params[:id])
    @slots=@timeslot.slots
  end


  def list_doctors
    department_id=params[:department_id]
    @available_doctors= Doctor.find(:all, :conditions => {:department_id => department_id})
    @timeslot=Timeslot.new
    render :update do |page|
      page.replace_html 'available_doctors' ,:partial =>'available_doctors'
    end
  end



end
