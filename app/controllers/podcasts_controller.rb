class PodcastsController < ApplicationController

  def index
    @podcasts = Podcast.all.order( "created_at DESC" )

    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  def show
    @podcast = Podcast.friendly.find( params[:id] )
  end

end
