require 'fastercsv'
class Room < ActiveRecord::Base
  has_many :beds, :dependent => :destroy

  validates_presence_of :number

  def self.to_csv
    @rooms=Room.all
    FasterCSV.generate do |csv|
      csv << ["number", "total no of beds", ]
      @rooms.each do |r|
        csv << [ r.id, r.no_of_beds ]
      end
    end
  end
end
