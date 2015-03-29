class AddSchoolToConfessions < ActiveRecord::Migration
  def change
    add_column :confessions, :school_id, :integer
  end
end
