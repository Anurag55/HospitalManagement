class Doctor < ActiveRecord::Base
  has_one :user, :as => :profile, :dependent => :destroy
  belongs_to :department
  has_many :appointments
  has_many :patients, :through => :appointments
  has_many :timeslots, :dependent => :destroy

  validates_presence_of  :first_name, :last_name, :date_of_birth, :gender, :qualification, :experience, :nationality_id

end
