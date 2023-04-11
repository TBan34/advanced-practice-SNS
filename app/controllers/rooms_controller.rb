class RoomsController < ApplicationController
  
  def create
    @room = Room.create
    @current_user_room = UserRoom.create(room_id: @room.id, user_id: current_user.id)
    @another_user_room = UserRoom.create(room_id: @room.id, user_id: params[:user_id])
    redirect_to room_path(@room.id)
  end
  
  def show
    @room = Room.find(params[:id])
  end
  
end
