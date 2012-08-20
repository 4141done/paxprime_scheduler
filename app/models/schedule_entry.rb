class ScheduleEntry < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :event
end