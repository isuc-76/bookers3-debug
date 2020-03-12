class BookCommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy]

	def create
		book = Book.find(params[:book_id])
		comment = current_user.book_comments.new(book_comment_params)
		comment.book_id = book.id
		p "コメント"
		if comment.save
		redirect_to book_path(book.id)
		else
			redirect_to book_path(book.id)
			# @showbook = Book.find(params[:id])
		 #    @book = Book.new
		 #    @user = @showbook.user
			# render template: 'books/show'
		end
	end

	def destroy
		# ↓BookCommentモデルのidを持ってくる
		comment = BookComment.find(params[:id])
		# ↓find_byで上から順々にデータを取得してしまうため、任意のコメントを削除できない
		# book = Book.find(params[:book_id])
		# comment = current_user.book_comments.find_by(book_id: book.id)
		comment.destroy
		# ↓book_id(=book.id)をparamsで渡してリダイレクトする
		redirect_to book_path(params[:book_id])
	end


  private

	def book_comment_params
	    params.require(:book_comment).permit(:comment)
	end

    def correct_user
      @book_comment = BookComment.find(params[:book_id])
      @user = @book_comment.user
      if current_user != @user
        redirect_to book_path(book.id)
      end
    end

end
