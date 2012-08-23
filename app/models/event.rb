class Event < ActiveRecord::Base
  # todo: account for all day events so that they don't conflict
  belongs_to :venue
  has_and_belongs_to_many :panelists
  default_scope :order => 'start_time DESC'

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




end