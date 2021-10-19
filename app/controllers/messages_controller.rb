class MessagesController < ApplicationController

  before_action :require_user

  def create
    message = current_user.messages.build(message_params)
    if message.save
      # redirect_to chatroom_path
      ActionCable.server.broadcast "chatroom_channel",
                                    mod_message: message_render(message)
    end
  end

  # def create_private
  #   message = current_user.messages.build(message_params)
  #   if message.save
  #     # redirect_to user_room_path(user.id)
  #     ActionCable.server.broadcast "userroom_channel#{params[:id]}" ,
  #                                   mod_message: message_render_private(message)
  #   end
  # end

  public
  def message_params
    params.require(:message).permit(:body)
  end

  def message_render(message)
    render(partial: 'message', locals: {message: message})
  end

  # def message_render_private(message)
  #   render (partial:'userroom/message', locals: {message: message})
  # end


end
