class FavoritesController < ApplicationController

	def create
		# @favorite = current_user.favorites.create(book_id: params[:book_id])
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.new(book_id: book.id)
		p "saveまえ"
		favorite.save!
		p "saveあと"
		redirect_to books_path
	end

	def destroy
		# @favorite = Favorite.find_by(book_id: params[:book_id], user_id: current_user.id)
  #   	@favorite.destroy
		book = Book.find(params[:book_id])
		favorite = current_user.favorites.find_by(book_id: book.id)
		favorite.destroy
		redirect_to books_path
	end

	

end
