class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string  :username
      t.string  :password
      t.string  :email
      t.string  :contact_number
      t.string :confirmation_token
      t.string :reset_token
      t.integer :confirmed, :default => 1
      t.integer :profile_created, :default => 0
      t.references :profile, :polymorphic => true, :index => true
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
