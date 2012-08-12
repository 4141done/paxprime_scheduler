class CreatePanelistsTable < ActiveRecord::Migration
  def up
    create_table :panelists do |t|
      t.string :name
      t.text :title
      t.string :affiliation
      t.string :twitter
 
      t.timestamps
    end
  end

  def down
    drop_table :panelists
  end
end
