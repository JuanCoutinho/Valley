class CreatePosts < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
