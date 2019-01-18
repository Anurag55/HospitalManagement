# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

require 'open-uri'
require 'active_record/fixtures'

["A+", "O+", "B+","AB+", "A-", "O-", "B-", "AB-"].each do |bg|
  BloodGroup.find_or_create_by_name(bg)
end

Country.delete_all
open("/home/foradian/assignment/test2/HospitalManagement/db/country_list.txt") do |countries|
  countries.read.each_line do |country|
    code, name = country.chomp.split("|")
    Country.create!(:name => name, :code => code)
  end
end


User.create(:username => "anurag", :password => "password", :email => "anuragmpayam@gmail.com", :contact_number => "9898563259", :confirmed => "1", :profile_created => "1", :profile_type => "Admin")
