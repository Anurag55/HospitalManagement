class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
      t.integer :number
      t.datetime :time
      t.references :patient
      t.references :doctor
      t.references :slot
      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
