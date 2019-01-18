class Timeslot < ActiveRecord::Base
  has_many :slots, :dependent => :destroy
  belongs_to :doctor

  validates_presence_of :date, :start_time, :end_time, :slot_width, :doctor_id

  def generate_slots

    slot_width = self.slot_width
    new_timeslot=self.start_time
    c=1
    while new_timeslot <= self.end_time
      print "Inside slots"
      slot=Slot.new(:number => c, :date => new_timeslot.to_date, :time => new_timeslot, :timeslot_id => self.id)
      c=c+1
      new_timeslot=new_timeslot+slot_width*60
      if new_timeslot <= self.end_time
        slot.save
      end
    end

  end

end
