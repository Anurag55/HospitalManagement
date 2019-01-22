require 'digest/sha1'
class User < ActiveRecord::Base
  belongs_to :profile, :polymorphic => true

  validates_presence_of  :username, :email, :contact_number
  validates_uniqueness_of :email, :username
  before_save :encrypt_password

  def role_symbols
      profile_type.underscore.to_sym.to_a
  end

  def encrypt_password
    if password_changed?
      self.password= Digest::SHA1.hexdigest(password)
    end
  end

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  GENDER = {1 => 'Male', 2 => 'Female', 3 => 'Others' }

  def find_gender
    GENDER[gender]
  end

  def update_profile patient
    self.profile = patient
    update_attributes(:profile_created => 1)
  end

end
