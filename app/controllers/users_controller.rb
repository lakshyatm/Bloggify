class UsersController < ApplicationController

  before_action :set_user, only: [:show,:edit,:update,:destroy]
  before_action :require_user, only: [:edit,:update,:destroy]
  before_action :require_same_user, only: [:edit,:update,:destroy]

  def show
    #  @user = User.find(params[:id])
    # @articles = @user.articles
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id    #as soon as the user sign up, make him logged in
      flash[:notice]="Welcome to Bloggify #{@user.username}, you have successfully signed up!!"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit 
    # @user = User.find(params[:id])
   
  end

  def update
    # @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:notice]="Updated profile successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end

  end

  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def destroy
    @user.destroy
    session[:user_id] = nil if @user==current_user
    flash[:notice] = "Account and all the associated articles successfully deleted!!"
    if @user==current_user
      redirect_to root_path 
    else
      redirect_to articles_path
    end
    
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password, :image)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user!=@user && !current_user.admin?
      flash[:alert]="You can only edit or delete your own account!!"
      redirect_to user_path(current_user)
    end
  end



end