class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient
  has_one :medical_record
  has_one :admit
  belongs_to :slot
  has_one :record

  validates_presence_of  :patient_id, :doctor_id, :slot_id
  validate :time_cannot_be_in_the_past

  after_save :set_slot_to_allocated, :deliver_appointment_email

  def time_cannot_be_in_the_past
    errors.add(:time, "can't be in the past") if
      !time.blank? and time < Time.current
  end

  def deliver_appointment_email
    UserMailer.deliver_appointment_email(Patient.find(patient_id).user,self)
  end

  def set_slot_to_allocated
    slot.update_attributes(:is_allocated => 1)
  end

end
