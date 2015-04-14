class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :comments_count
      t.timestamps null: false
    end

    add_index :topics, :user_id

  end
end
