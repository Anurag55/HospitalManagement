class Record < ActiveRecord::Base
  belongs_to :appointment

  has_attached_file :file, :url => "/:attachment/:id/:style/:basename.:extension", :download=>false,
   :path => ":rails_root/public/:attachment/:id/:style/:basename.:extension"
   validates_attachment_content_type :file, :content_type => ["application/pdf", "image/jpeg", "image/png"]

   after_save :update_bed_admit_attributes

   def update_bed_admit_attributes
     self.appointment.admit.update_attributes(:discharged_date => Date.current, :is_discharged => 1)
     self.appointment.admit.bed.update_attributes(:is_allocated => 0)
   end


end
