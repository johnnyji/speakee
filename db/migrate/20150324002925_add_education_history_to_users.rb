class AddEducationHistoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :education_history, :string
  end
end
