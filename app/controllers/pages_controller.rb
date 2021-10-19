class PagesController < ApplicationController

  def home
    # render json: logged_in?
    # return

    redirect_to articles_path if logged_in?
  end

  def about
  end
end
