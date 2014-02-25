class SiteController < ApplicationController
  def index
  	# retrieve all Bookmarks ordered by descending creation timestamp
    #@bookmarks = Bookmark.order('created_at desc')
    if current_user
    	@bookmarks = current_user.bookmarks.order('created_at desc')
    else
    	render 'index'
    end
  end
end
