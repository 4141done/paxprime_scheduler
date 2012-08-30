class SharedSchedule < ActiveRecord::Base
  attr_accessible :user_id , :schedule_id, :message, :sending_user_id
  has_one :user
  has_one :schedule

  def self.get_existing_shared_schedule_for_pair sender, receiver
    SharedSchedule.find_by_sending_user_id_and_user_id sender, receiver
  end
end