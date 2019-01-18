class CreateMedicalRecords < ActiveRecord::Migration
  def self.up
    create_table :medical_records do |t|
      t.string :comments
      t.string :patient_condition
      t.string :medication
      t.integer :is_recommended, :default => 0
      t.integer :is_admitted, :default => 0
      t.references :appointment
      t.timestamps
    end
  end

  def self.down
    drop_table :medical_records
  end
end
