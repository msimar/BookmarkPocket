class BookmarksController < ApplicationController
  before_action :set_bookmark, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user! 
  

  # GET /bookmarks
  # GET /bookmarks.json
  def index
    #@bookmarks = Bookmark.all
    @bookmarks = current_user.bookmarks.order('created_at desc')
  end

  # GET /bookmarks/1
  # GET /bookmarks/1.json
  def show
  end

  # GET /bookmarks/new
  def new
    @bookmark = current_user.bookmarks.new
  end

  # GET /bookmarks/1/edit
  def edit
  end

  # POST /bookmarks
  # POST /bookmarks.json
  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)

    if @bookmark.save
      redirect_to @bookmark, notice: 'Bookmark was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bookmarks/1
  # PATCH/PUT /bookmarks/1.json
  def update
    if @bookmark.update(bookmark_params)
      redirect_to @bookmark, notice: 'Bookmark was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /bookmarks/1
  # DELETE /bookmarks/1.json
  def destroy
    @bookmark.destroy
    redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bookmark
      unless @bookmark = current_user.bookmarks.where(id: params[:id]).first
        flash[:alert] = 'Bookmark not found.'
        redirect_to root_url
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bookmark_params
      params.require(:bookmark).permit(:title, :url, :user_id)
    end
end
