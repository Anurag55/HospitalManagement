class MedicalRecord < ActiveRecord::Base
  belongs_to :appointment

  validates_presence_of :comments, :patient_condition, :medication, :appointment_id


end
