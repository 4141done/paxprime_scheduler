class CreateUsersTable < ActiveRecord::Migration
  def up
    create_table :users do |t|
        t.text :identifier
        t.text :email
    end
  end

  def down
    drop_table :users
  end
end
