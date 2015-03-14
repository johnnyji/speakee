class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :first_name
      t.string :last_name
      t.string :oauth_token
      t.datetime :oauth_expiry_date

      t.timestamps null: false
    end
  end
end
