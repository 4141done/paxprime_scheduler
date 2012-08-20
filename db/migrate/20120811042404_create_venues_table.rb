class CreateVenuesTable < ActiveRecord::Migration
  def up
    create_table :venues do |t|
      t.text :name
      t.text :description
      t.text :address
      t.text :city
      t.text :state
      t.text :zip
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
