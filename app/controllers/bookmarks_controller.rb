class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    cat = Cat.find(params[:cat_id])
    current_user.bookmark(cat)
    redirect_to cat_path(cat)
  end

  def destroy
    cat = current_user.bookmarks.find(params[:id]).cat
    current_user.unbookmark(cat)
    redirect_to cat_path(cat)
  end
end
