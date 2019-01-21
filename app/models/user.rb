class User < ActiveRecord::Base
  belongs_to :profile, :polymorphic => true

  validates_presence_of  :username, :email, :contact_number
  validates_uniqueness_of :email
  def role_symbols
      profile_type.underscore.to_sym.to_a
  end

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  GENDER = {1 => 'Male', 2 => 'Female', 3 => 'Others' }

  def find_gender
    GENDER[gender]
  end

  def update_profile
    update_attributes(:profile_created => 1)
    save
  end

end
