class AddSendingUserIdToSharedSchedules < ActiveRecord::Migration
  def change
    add_column :shared_schedules, :sending_user_id, :integer
  end
end
