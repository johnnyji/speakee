class AddCurrentSchoolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :current_school, :string
  end
end
