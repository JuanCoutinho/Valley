class AddDetailsToProjects < ActiveRecord::Migration[7.1]
  def change
    add_column :projects, :aim, :text
    add_column :projects, :features, :text
    add_column :projects, :guide, :text
    add_column :projects, :github_link, :string
    add_column :projects, :images, :string
    add_column :projects, :investment, :decimal
  end
end
