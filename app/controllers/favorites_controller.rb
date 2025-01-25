class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    @favorite = Favorite.new(book_id: book.id)
    @favorite.user_id = current_user.id
    @favorite.save
    render "replace_favorite"
  end

  def destroy
    book = Book.find(params[:book_id])
    @favorite = current_user.favorites
    @favorite = @favorite.find_by(book_id: book.id)
    @favorite.destroy
    render "replace_favorite"
  end
end
