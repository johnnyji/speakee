class AddActiveSchoolToUsers < ActiveRecord::Migration
  def change
    add_column :users, :active_school, :integer
  end
end
