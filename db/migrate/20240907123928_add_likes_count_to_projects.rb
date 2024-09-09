class AddLikesCountToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :likes_count, :integer
  end
end
