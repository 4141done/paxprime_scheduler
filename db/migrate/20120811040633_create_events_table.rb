class CreateEventsTable < ActiveRecord::Migration
  def up
    create_table :events do |t|
      t.text :name
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.references :venue
      t.string :chaos
 
      t.timestamps
    end
  end

  def down
    drop_table :events
  end
end
