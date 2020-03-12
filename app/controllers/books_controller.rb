class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
  	@showbook = Book.find(params[:id])
    @book = Book.new
    @user = @showbook.user
    @book_comment = BookComment.new
    @book_comments = BookComment.where(book_id: @showbook)
  end

  def index
  	@books = Book.all#一覧表示するためにBookモデルの情報を全てくださいのall
    # @showbook = @books.find(params[:id])
    @book = Book.new
    @user = current_user
    @favorite = Favorite.new
  end

  def create
    # p "newbookだよ"
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
  	if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
      @user = current_user
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

      def correct_user
        @book = Book.find(params[:id])
        @user = @book.user
        if current_user != @user
          redirect_to books_path
        end
      end

  def book_params
  	params.require(:book).permit(:title, :body)
  end

end
