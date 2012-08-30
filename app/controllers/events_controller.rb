class EventsController < ApplicationController
  def show
    @user = User.find_by_identifier params[:user]
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
    @user = User.find_by_identifier params[:user]
    query = params[:query]
    @results = PgSearch.multisearch(query)

    @events = []

    @results.each do |pgs|
      result = pgs.searchable_type.constantize.find pgs.searchable_id

      case result
      when Event
        @events << result
      when Panelist
        result.events.each do |e|
          @events << e
        end
      end
    end

    @events.uniq!
    
    render :layout => false, :template => 'events/show'
  end
end