class ChatroomController < ApplicationController

  before_action :require_user, only: [:index]

  def index
    @user = current_user
    @message = Message.new
    @messages = Message.all
    @users = User.all
  end



end