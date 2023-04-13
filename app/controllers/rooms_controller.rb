class RoomsController < ApplicationController
  
  def create
    @room = Room.create
    @current_user_room = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    @another_user_room = UserRoom.create(params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end
  
  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
      @user_rooms = @room.user_rooms
    end
  end
  
end
