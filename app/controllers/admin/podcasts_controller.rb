class Admin::PodcastsController < ApplicationController
  def index
    @podcasts = Podcast.all.order( "created_at DESC" )
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new

    if @podcast.create( podcast_params )
      render :new
      flash.now[:success] = "You created your podcast."
    else
      render :new
      flash.now[:error] = "Something went wrong! Try again."
    end
  end

  def edit
    @podcast = Podcast.find( params[:id] )
  end

  def update
    @podcast = Podcast.find( params[:id] )

    if @podcast.save
      render :edit
      flash.now[:success] = "You updated your post."
    else
      render :edit
      flash.now[:error] = "Something went wrong! Try again."
    end
  end

  private

  def podcast_params
    params.require( :podcast ).permit(
      :date,
      :description,
      :main_image,
      :secondary_image,
      :title,
      :visible
    )
  end
end
