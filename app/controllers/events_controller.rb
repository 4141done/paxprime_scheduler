class EventsController < ApplicationController
  def show
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
    render :layout => false, :template => 'events/show'
  end
end