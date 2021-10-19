class UserroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "userroom_channel#{params[:id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
