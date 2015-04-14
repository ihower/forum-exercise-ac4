class CreateTopicCategories < ActiveRecord::Migration
  def change
    create_table :topic_categories do |t|
      t.integer :topic_id
      t.integer :category_id
      t.timestamps null: false
    end

    add_index :topic_categories, :topic_id
    add_index :topic_categories, :category_id
  end
end
