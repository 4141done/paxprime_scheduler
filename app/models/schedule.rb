class Schedule < ActiveRecord::Base
  has_many :schedule_entries
  has_many :events, :through => :schedule_entries

  def saturday
  	events.where( :day => "SATURDAY" )
  end

  def sunday
  	events.where( :day => "SUNDAY" )
  end

  def friday
  	events.where( :day => "FRIDAY" )
  end
end