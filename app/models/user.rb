class User < ActiveRecord::Base
  belongs_to :profile, :polymorphic => true

  validates_presence_of  :username, :email, :contact_number
  validates_uniqueness_of :email
  def role_symbols
      return self.profile_type.underscore.to_sym.to_a
  end

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>"}

  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :url => "/system/:style/.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\z/

    GENDER = {1 => 'Male', 2 => 'Female', 3 => 'Others' }

    def find_gender
      GENDER[gender]
    end

    def update_profile
      self.update_attributes(:profile_created => 1)
      self.save
    end

end
