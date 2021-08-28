class UsersController < ApplicationController
  
  before_action :baria_user, only: [:edit, :destroy, :update]
  
  def show
    @user = User.find(params[:id])
    @userbooks = @user.books
    @book = Book.new
    
  end

  def index
    @books =Book.all
    @user = current_user
    @book = Book.new
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params) then redirect_to user_path(@user.id), notice: "successfully"
    else render :edit
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :image)  
  end
  
  def baria_user
    redirect_to user_path(current_user) unless User.find(params[:id]) == current_user
  end
end