class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient
  has_one :medical_record
  has_one :admit
  belongs_to :slot
  has_one :record

  validates_presence_of  :time, :patient_id, :doctor_id, :slot_id

  after_save :set_slot_to_allocated

  def set_slot_to_allocated
    self.slot.update_attributes(:is_allocated => 1)
  end

end
