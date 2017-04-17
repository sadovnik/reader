class AddFavoriteStatusColumnToPostEntries < ActiveRecord::Migration[5.0]
  def change
    add_column :post_entries, :favorite_status, :integer, default: 0
  end
end
