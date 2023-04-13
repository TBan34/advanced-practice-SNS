class ChatsController < ApplicationController
  
  def create
    @chat = Chat.new
    redirect_to request.referer
  end
  
  private
    def chat_params
      params.require(:chat).permit(:room_id, :message)
    end
end
