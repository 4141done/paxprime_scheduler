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

  def venues
    venues = []
    schedule_entries.each do |se|
      venues << se.venue
    end
    venues.uniq!
    return venues
  end

  def events_at_venue venue_id
    events.where :venue_id => venue_id
  end
end