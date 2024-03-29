class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :text
      t.string :title
      t.integer :comments_counter, default: 0
      t.integer :likes_counter, default: 0
      t.references :author, null: false, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
