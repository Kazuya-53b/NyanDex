class CreateBookmarks < ActiveRecord::Migration[7.2]
  def change
    create_table :bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :cat, null: false, foreign_key: true

      t.timestamps
    end
    add_index :bookmarks, [:user_id, :cat_id], unique: true
  end
end
