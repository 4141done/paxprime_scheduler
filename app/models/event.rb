class Event < ActiveRecord::Base
  include PgSearch
  multisearchable :against => [:name, :description, :day, :start_time]

  # todo: account for all day events so that they don't conflict
  belongs_to :venue
  has_and_belongs_to_many :panelists

  def day
    start_time.strftime("%^A")
  end

  def self.find_using_panelist panelist
    Event.find(:all, :include=>:panelists, :conditions => ['panelists.id in (?)',[panelist]])
  end

  def self.find_with_filters opts={}
    panelist = opts[:panelist]
    opts.delete :panelist
    events = []

    if opts.present?
      events = Event.where(opts)
      events = events.find(:all, :include=>:panelists, :conditions => ['panelists.id in (?)',[panelist]]) unless panelist.blank?
    else
      if panelist
        events = Event.find_using_panelist panelist
      end
    end
    
    return events
  end

  def conflicts
    Event.where("? between start_time and end_time
                  OR ? between start_time and end_time
                  OR start_time between ? and ?
                  OR end_time between ? and ?",start_time, end_time, start_time, end_time, start_time, end_time)
  end

  def conflicts_in_schedule schedule_id
    schedule = Schedule.find schedule_id
    schedule.events.where("? between start_time and end_time
                  OR ? between start_time and end_time
                  OR start_time between ? and ?
                  OR end_time between ? and ?",start_time, end_time, start_time, end_time, start_time, end_time)
  end
end