class AddUserIdToConfessions < ActiveRecord::Migration
  def change
    add_column :confessions, :user_id, :integer
  end
end
