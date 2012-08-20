class CreatePanelistsTable < ActiveRecord::Migration
  def up
    create_table :panelists do |t|
      t.text :name
      t.text :title
      t.text :affiliation
      t.text :twitter
 
      t.timestamps
    end
  end

  def down
    drop_table :panelists
  end
end
