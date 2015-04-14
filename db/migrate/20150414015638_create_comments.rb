class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|

      t.integer :topic_id
      t.text :content
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :comments, :topic_id
    add_index :comments, :user_id

  end

end
