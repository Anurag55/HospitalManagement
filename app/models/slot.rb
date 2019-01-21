class Slot < ActiveRecord::Base
  belongs_to :timeslot
  has_many :appointments

  validates_presence_of :number, :date, :time, :timeslot_id
end
