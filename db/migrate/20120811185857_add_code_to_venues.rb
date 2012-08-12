class AddCodeToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :code, :string
  end
end
