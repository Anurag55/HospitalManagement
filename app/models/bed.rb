class Bed < ActiveRecord::Base
  belongs_to :room
  validates_presence_of :number, :room_id
  has_many :admits

  after_save :increment_bed_count

  def increment_bed_count
    room.update_attributes(:no_of_beds => room.beds.count)
  end
end
