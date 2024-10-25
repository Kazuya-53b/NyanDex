# app/controllers/bookmarks_controller.rb
class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @bookmark = current_user.bookmarks.new(cat_id: params[:cat_id])
    if @bookmark.save
      redirect_to cat_path(params[:cat_id]), notice: 'ブックマークしました'
    else
      redirect_to cat_path(params[:cat_id]), alert: 'ブックマークに失敗しました'
    end
  end

  def destroy
    @bookmark = current_user.bookmarks.find_by(cat_id: params[:cat_id])
    if @bookmark.destroy
      redirect_to cat_path(params[:cat_id]), notice: 'ブックマークを解除しました'
    else
      redirect_to cat_path(params[:cat_id]), alert: 'ブックマーク解除に失敗しました'
    end
  end
end
