class AddUrlToEvents < ActiveRecord::Migration
  def change
    add_column :events, :url, :text
  end
end
