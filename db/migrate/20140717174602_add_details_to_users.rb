class AddDetailsToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :nickname, :string
  	add_column :users, :phone_number, :string
    add_column :users, :status, :string

  	# Mobile Verification
    add_column :users, :verification_code, :string
    add_column :users, :verified_at, :datetime
    add_column :users, :verification_sent_at, :datetime

  	# Store the client correlator to be able to query for the sms delivery status later
  	add_column :users, :client_correlator, :string

  	# add_index :users, :phone_number, unique: true
  end
end
