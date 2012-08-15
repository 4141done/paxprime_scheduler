class CreateSchedulesTable < ActiveRecord::Migration
  def up
    create_table :schedules do |t|
        t.references :user
    end
  end

  def down
    drop_table :schedules
  end
end
