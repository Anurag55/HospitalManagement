class CreateBeds < ActiveRecord::Migration
  def self.up
    create_table :beds do |t|
      t.string :number
      t.integer :is_allocated, :default => 0 
      t.references :room
      t.timestamps
    end
  end

  def self.down
    drop_table :beds
  end
end
