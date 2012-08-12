class CreateEventsPanelistsTable < ActiveRecord::Migration
  def up
    create_table :events_panelists, :id => false do |t|
        t.references :event
        t.references :panelist
    end
    add_index :events_panelists, [:event_id, :panelist_id]
    add_index :events_panelists, [:panelist_id, :event_id]
  end

  def down
    drop_table :events_panelists
  end
end
