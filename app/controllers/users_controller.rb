class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def index
    @users = User.all
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    
    current_user_room = UserRoom.where(user_id: current_user.id)
    another_user_room = UserRoom.where(user_id: @user.id)
    unless @user.id == current_user.id
      current_user_room.each do |cu|
        another_user_room.each do |au|
          if cu.room_id == au.room_id then
            @is_room = true
            @room = cu.room_id
          end
        end
      end
      unless @is_room
        @room = Room.new
        @user_room = UserRoom.new
      end
    end
  end

  def edit
    user_id = params[:id].to_i
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to current_user
    end

    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end