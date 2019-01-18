class CreateTimeslots < ActiveRecord::Migration
  def self.up
    create_table :timeslots do |t|
      t.string :number
      t.date :date
      t.datetime :start_time
      t.datetime :end_time
      t.integer :slot_width
      t.references :doctor
      t.timestamps
    end
  end

  def self.down
    drop_table :timeslots
  end
end
