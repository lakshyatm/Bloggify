class ArticlesController < ApplicationController
  #before_action is used to call the method set_article before the methods show,edit,update,destroy. set_article is used to avoid redundant code!!
  before_action :set_article,only: [:show,:edit,:update,:destroy]

  before_action :require_user, except: [:show,:index]

  before_action :require_same_user, only: [:edit,:destroy,:update]

  def show 
    # @ is used for converting variable into instance so that it is accessible in show template 
    # @article = Article.find(params[:id])
  end

  def index
    # @articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def create
    # @article = Article.new(title:params[:article][:title],description:params[:article][:description])                # Second method to access @article
    @article = Article.new(article_params)    
    @article.user=current_user
    if @article.save
      #Flash is a ROR helper used to display flash messages.
      flash[:notice]="Article was created successfully!!"
    # Path for redirecting to show, We see it using routes in console. cmd == rails routes --expanded
      redirect_to article_path(@article)   #Shortcut:redirect_to @article 
    else            #else condition is true when the title/description are     not of required length
      render 'new'  #render to new action 
    end
  end

  def edit
    # @article = Article.find(params[:id])  #params([:id]) return the id of the article
  end

  def update
    # @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice]="Article updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    # @article=Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  private
  def set_article
    @article=Article.find(params[:id])
  end

  def article_params   #it is basically white listing title,description and category ids
    params.require(:article).permit(:title,:description, category_ids: [])
  end

  def require_same_user
    if current_user!=@article.user && !current_user.admin?
      flash[:alert]="You can only edit or delete your own article!!"
      redirect_to @article
    end
  end


end