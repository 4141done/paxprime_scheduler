class CreateSharedSchedulesTable < ActiveRecord::Migration
  def up
  	create_table :shared_schedules do |t|
      t.references :schedule
      t.references :user
      t.text :message
      t.timestamps
    end
  end

  def down
  	drop_table :shared_schedules
  end
end
