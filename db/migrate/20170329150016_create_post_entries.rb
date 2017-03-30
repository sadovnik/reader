class CreatePostEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :post_entries do |t|
      t.references :post, foreign_key: true
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
