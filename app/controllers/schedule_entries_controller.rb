class ScheduleEntriesController < ApplicationController
  def create
    # ap params
    # user = User.find_by_identifier(params[:user])

    entry = ScheduleEntry.new
    entry.event = Event.find params[:event_id].to_i
    @current_user.schedule.schedule_entries << entry
    @current_user.save!

    render :nothing => true
  end

  def update
  end

  def destroy
    ap params
    user = User.find_by_identifier(params[:user])
    if user
      ap params[:event_id].to_i
      entry = ScheduleEntry.new
      entry.event = Event.find params[:event_id].to_i
      user.schedule.schedule_entries << entry
      user.save!
    end
  end
end