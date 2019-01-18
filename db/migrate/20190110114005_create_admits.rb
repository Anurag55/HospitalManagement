class CreateAdmits < ActiveRecord::Migration
  def self.up
    create_table :admits do |t|
      t.datetime :date
      t.datetime :time
      t.integer :is_discharged, :default => 0
      t.datetime :discharged_date
      t.references :bed
      t.references :appointment
      t.timestamps
    end
  end

  def self.down
    drop_table :admits
  end
end
