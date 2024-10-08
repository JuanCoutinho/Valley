class AddLikesCountToProjects < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    add_column :projects, :likes_count, :integer
  end
end
