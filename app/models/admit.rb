class Admit < ActiveRecord::Base
  belongs_to :appointment
  belongs_to :bed
  validates_presence_of  :bed_id, :date, :time

  after_save :update_bed_and_record_statuses

  def update_bed_and_record_statuses
    appointment.medical_record.update_attributes(:is_admitted => 1)
    bed.update_attributes(:is_allocated => 1)
  end

end
