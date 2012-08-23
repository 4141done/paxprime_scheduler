class SharedSchedulesController < ApplicationController
  def create
    recipient = User.find_by_identifier params[:friend]
    if recipient
      me = User.find_by_identifier params[:user]
      to_send = SharedSchedule.new 
      to_send.user_id = recipient.id
      to_send.schedule_id =  me.schedule.id
      to_send.message = params[:message]
      to_send.save!
      render :nothing => true and return
    end
    render :nothing => true, :status => 500
  end
end