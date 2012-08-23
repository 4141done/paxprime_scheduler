class SchedulesController < ApplicationController
  def show
    @user = User.find_by_identifier(params[:user])
    @schedule = @user.schedule
    @shared_schedules = @user.shared_schedules
    
    render :layout => false
  end

end