class CreateSchoolUsers < ActiveRecord::Migration
  def change
    create_table :school_users do |t|
      t.references :user, index: true
      t.references :school, index: true
    end
    add_foreign_key :school_users, :schools
    add_foreign_key :school_users, :users
  end
end
