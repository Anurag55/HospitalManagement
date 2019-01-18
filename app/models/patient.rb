class Patient < ActiveRecord::Base
    has_one :user, :as => :profile, :dependent => :destroy
    has_many :appointments
    has_many :doctors, :through => :appointments


    validates_presence_of :first_name, :last_name, :date_of_birth, :address,:gender, :blood_group_id


end
