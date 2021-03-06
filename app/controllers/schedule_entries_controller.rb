class ScheduleEntriesController < ApplicationController
  def create
    @user = User.find_by_identifier params[:user]
    entry = ScheduleEntry.new
    entry.event = Event.find params[:event_id].to_i
    @user.schedule.schedule_entries << entry
    @user.save!

    render :nothing => true
  end

  def update
  end

  def destroy
    @user = User.find_by_identifier(params[:user])
    if @user
      entry = @user.schedule_entries.find_by_event_id params[:event_id].to_i
      if entry
        ScheduleEntry.destroy(entry.id)
      end
    end
    render :nothing => true
  end
end