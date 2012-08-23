class SchedulesController < ApplicationController
  def show
    @user = User.find_by_identifier(params[:user])
    @schedule = @user.schedule
    
    render :layout => false
  end

end