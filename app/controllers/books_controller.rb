class BooksController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def new
    @books = Book.new
  end

  def create
    @newbook = Book.new(book_params)
    @newbook.user_id = current_user.id
     if @newbook.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@newbook.id)
     else
      @books = Book.all
      render :index
     end
  end

  def index
    @books = Book.all
    @newbook = Book.new
    @newbook.user_id = current_user.id
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.all
    @newbook = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    book.user_id = current_user.id
    if book.update(book_params)
     flash[:notice] = "You have updated book successfully."
     redirect_to book_path(params[:id])
    else
     @book = book
     render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    flash[:notice] = "successfully destroyed."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end

  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    unless @user == current_user
      redirect_to books_path
    end
  end
end

