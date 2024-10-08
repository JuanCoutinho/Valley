class CreateLikes < ActiveRecord::Migration[7.1] # rubocop:disable Style/Documentation
  def change
    create_table :likes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
