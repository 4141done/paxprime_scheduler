class ScheduleEntry < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :event
  has_one :venue, :through => :event
end