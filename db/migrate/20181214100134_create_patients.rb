class CreatePatients < ActiveRecord::Migration
  def self.up
    create_table :patients do |t|
      t.string  :first_name
      t.string  :middle_name
      t.string  :last_name
      t.date    :date_of_birth
      t.string  :address
      t.string  :gender
      t.references :blood_group
      t.timestamps
    end
  end

  def self.down
    drop_table :patients
  end
end
