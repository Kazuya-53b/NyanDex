class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cat

  def create
    @bookmark = current_user.bookmarks.new(cat_id: params[:cat_id])
    if @bookmark.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @cat, notice: 'ブックマークしました' }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to cat_path(@cat), alert: 'ブックマークに失敗しました' }
      end
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(cat: @cat)
    @bookmark.destroy if @bookmark
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @cat, notice: 'ブックマークを解除しました' }
    end
  end
end
