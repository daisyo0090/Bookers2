class BooksController < ApplicationController
  
  before_action :baria_user, only: [:edit, :destroy, :update]
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  
  def show
    @mybook = Book.find(params[:id])
    @book = Book.new
    @user = @mybook.user
    
  end
  
  def edit
    @book = Book.find(params[:id])
    
  end
  
  def create
    
    @book = Book.new(book_params)
    @user = current_user
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice:"successfully"
    else
      @books = Book.all
      render :index
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice: "successfully"
    else
      render :edit
    end
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path, notice: "successfully"
  end
  
   private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def baria_user
    book = Book.find(params[:id])
    user = book.user
    unless user == current_user
        redirect_to books_path
    end
  end
  
  
end
