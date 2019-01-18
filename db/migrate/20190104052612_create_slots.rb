class CreateSlots < ActiveRecord::Migration
  def self.up
    create_table :slots do |t|
      t.integer :number
      t.date :date
      t.datetime :time
      t.integer :is_allocated, :default => 0
      t.references :timeslot
      t.timestamps
    end
  end

  def self.down
    drop_table :slots
  end
end
