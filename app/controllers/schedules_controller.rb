class SchedulesController < ApplicationController
  def show 
      @user = User.find_by_identifier(params[:user])
      @schedule = @user.schedule
      @shared_schedules = @user.shared_schedules

      if params[:view] == "timeline"
        ap "rendering timeline view!"
        @venues = Venue.all
        @times = []
        start_day = Time.parse("10:00am")
        end_day = Time.parse("11:00pm")
        while start_day <= end_day
          @times << start_day
          start_day  += 30.minutes
        end
        render 'schedules/timeline', :layout => false and return
      else
        render :layout => false
      end
  end
end