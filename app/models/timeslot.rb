class Timeslot < ActiveRecord::Base
  has_many :slots, :dependent => :destroy
  belongs_to :doctor

  validates_presence_of :start_time, :end_time, :slot_width, :doctor_id
  validate :date_cannot_be_in_the_past
  after_update :generate_slots

  def date_cannot_be_in_the_past
    errors.add(:date, "can't be in the past") if
      !date.blank? and date < Date.today
  end

  def generate_slots
    width = slot_width
    new_timeslot = start_time
    c=1
    while new_timeslot <= end_time
      print "Inside slots"
      slot=Slot.new(:number => c, :date => new_timeslot.to_date, :time => new_timeslot, :timeslot_id => id)
      c=c+1
      new_timeslot=new_timeslot+width*60
      if new_timeslot <= end_time
        slot.save
      end
    end
  end
end
