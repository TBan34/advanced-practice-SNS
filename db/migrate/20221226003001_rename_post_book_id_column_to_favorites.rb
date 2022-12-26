class RenamePostBookIdColumnToFavorites < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites, :post_book_id, :book_id
  end
end
