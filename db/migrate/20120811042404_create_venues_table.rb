class CreateVenuesTable < ActiveRecord::Migration
  def up
    create_table :venues do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :chaos
      t.float :latitude
      t.float :longitude
 
      t.timestamps
    end
  end

  def down
    drop_table :venues
  end
end
