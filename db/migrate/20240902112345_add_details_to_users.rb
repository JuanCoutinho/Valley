class AddDetailsToUsers < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    add_column :users, :name, :string
    add_column :users, :user_type, :string
  end
end
