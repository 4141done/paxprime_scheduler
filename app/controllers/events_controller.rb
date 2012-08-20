class EventsController < ApplicationController
  def show
    ap @current_user
    options = { :day => params[:day],
                :start_time => params[:start],
                :end_time => params[:end],
                :panelist => params[:panelist],
                :affiliation => params[:affiliation],
                :venue_id => params[:venue]
              }
    options.reject!{|k,v| v.blank?}

    @events = Event.find_with_filters options

    @events = Event.all unless @events.present?
    ap "HERE THEY BE"
    @events.each do |e|
      ap @current_user.schedule.schedule_entries.find_by_event_id(e.id).is_a?(ScheduleEntry) ? "event added" : "event"
    end
    render :layout => false
  end

  def search
    ap @current_user
    query = params[:query]
    @results = Event.where "description LIKE ? OR name LIKE ?", "%#{query}%", "%#{query}%" #TODO add panelist search
    @events = []

    @results.each do |event|
      @events << event
    end
    ap @events
    @events.each do |e|
      ap @current_user.schedule.schedule_entries.find_by_event_id(e.id)
      ap @current_user.schedule.schedule_entries.find_by_event_id(e.id).is_a?(ScheduleEntry) ? "event added" : "event"
    end
    render :layout => false, :template => 'events/show'
  end
end