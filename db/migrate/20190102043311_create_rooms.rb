class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.string :number
      t.integer :no_of_beds, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :rooms
  end
end
