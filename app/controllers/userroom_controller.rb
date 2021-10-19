class UserroomController < ApplicationController

  before_action :require_user, only: [:index]

  def index
    @user = current_user
    @messages = Message.all
    @users = User.all
    @pmessage = Message.new
    @second_user = User.find(params[:id])
  end

end
