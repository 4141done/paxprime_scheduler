class SharedSchedulesController < ApplicationController
  def create
    recipient = User.find_by_identifier params[:friend]
    if recipient
      me = User.find_by_identifier params[:user]

      to_send = SharedSchedule.get_existing_shared_schedule_for_pair me.id, recipient.id
      if to_send
        to_send.update_attributes :user_id => recipient.id, :schedule_id => me.schedule.id, 
                                  :message => params[:message], :sending_user_id => me.id
      else
        to_send = SharedSchedule.new 
        to_send.user_id = recipient.id
        to_send.schedule_id =  me.schedule.id
        to_send.message = params[:message]
        to_send.sending_user_id = me.id
        to_send.save!
      end
      render :nothing => true and return
    end
    render :nothing => true, :status => 500
  end

  def show
    @shared_schedule = SharedSchedule.find params[:shared_schedule]
    @schedule = Schedule.find @shared_schedule.schedule_id
    @sharer = User.find @shared_schedule.sending_user_id
    @user = User.find_by_identifier params[:viewing_user]

    render :layout => false
  end
end