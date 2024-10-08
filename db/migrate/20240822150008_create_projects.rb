class CreateProjects < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    create_table :projects do |t|
      t.string :title
      t.text :ds_project

      t.timestamps
    end
  end
end
