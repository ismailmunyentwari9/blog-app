class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :author_id
      t.integer :post_id
      t.date :created_at
      t.date :updated_at
      t.timestamps
    end
    add_foreign_key :likes, :users, column: :author_id
    add_foreign_key :likes, :post, column: :post_id
    add_index :likes, :author_id
    add_index :likes, :post_id
  end
end
