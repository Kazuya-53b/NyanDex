class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @cat = Cat.find(params[:cat_id])
    current_user.bookmark(@cat)
    respond_to do |format|
      format.html { redirect_to cat_path(@cat) }
      format.turbo_stream
    end
  end

  def destroy
    @cat = current_user.bookmarks.find(params[:id]).cat
    current_user.unbookmark(@cat)
    respond_to do |format|
      format.html { redirect_to cat_path(@cat) }
      format.turbo_stream
    end
  end
end
