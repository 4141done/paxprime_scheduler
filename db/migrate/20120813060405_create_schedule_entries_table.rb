class CreateScheduleEntriesTable < ActiveRecord::Migration
  def up
    create_table :schedule_entries do |t|
      t.references :schedule
      t.references :event
      t.text :notes
    end
  end

  def down
    drop_table :schedule_entries
  end
end
