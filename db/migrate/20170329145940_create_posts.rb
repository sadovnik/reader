class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :guid
      t.string :title
      t.string :summary
      t.string :url
      t.references :source, foreign_key: true
      t.datetime :published_at

      t.timestamps
    end
  end
end
