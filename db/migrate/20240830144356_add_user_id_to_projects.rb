class AddUserIdToProjects < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    add_reference :projects, :user, null: false, foreign_key: true
  end
end
