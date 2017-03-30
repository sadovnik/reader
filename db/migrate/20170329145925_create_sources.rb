class CreateSources < ActiveRecord::Migration[5.0]
  def change
    create_table :sources do |t|
      t.string :title
      t.text :description
      t.integer :type
      t.string :url
      t.string :site_url

      t.timestamps
    end
  end
end
