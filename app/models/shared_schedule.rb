class SharedSchedule < ActiveRecord::Base
  has_one :user
  has_one :schedule
end