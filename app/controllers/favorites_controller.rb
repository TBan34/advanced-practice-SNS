class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:post_book_id])
    favorite = current_user.favorites.new(post_book_id: book.id)
    favorite.save
    redirect_to :back
    # 要見直し
  end

  def destroy
    book = Book.find(params[:post_book_id])
    favorite = current_user.favorites.ffind_by(post_book_id: book.id)
    favorite.destroy
    redirect_to :back
    # 要見直し
  end

end
