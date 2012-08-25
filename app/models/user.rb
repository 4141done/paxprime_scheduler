require 'user_names'
class User < ActiveRecord::Base
  include UserNames
  attr_accessible :identifier
  has_one :schedule
  has_many :schedule_entries,  :through => :schedule
  has_many :shared_schedules

  def self.generate_identifier
    # create a nice user name
    part_one = UserNames::NAMES[rand(UserNames::NAMES.length)]
    part_two = UserNames::NAMES[rand(UserNames::NAMES.length)]
    name = "#{part_one}_#{part_two}"
  end
end
