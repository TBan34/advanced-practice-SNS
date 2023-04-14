class ChatsController < ApplicationController
  
  def create
    @chat = Chat.new(chat_params.merge({ user_id: current_user.id }))
    @chat.save
    redirect_to request.referer
  end
  
  private
    def chat_params
      params.require(:chat).permit(:room_id, :message)
    end
end
