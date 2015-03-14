class AddOauthExpiryDateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :oauth_expiry_date, :datetime
  end
end
