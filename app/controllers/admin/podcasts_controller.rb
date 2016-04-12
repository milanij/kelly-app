class Admin::PodcastsController < ApplicationController
  before_action :authenticate_user!
  def index
    @podcasts = Podcast.all.order( "created_at DESC" )
  end

  def new
    @podcast = Podcast.new
  end

  def create
    @podcast = Podcast.new( podcast_params )

    if @podcast.save
      redirect_to(
        admin_podcasts_path,
        flash: {
          success: "You created the \"#{@podcast.title}\" podcast. "
        }
      )
    else
      render :new
      flash.now[:error] = "Something went wrong! Try again."
    end
  end

  def show
    @podcast = Podcast.find( params[:id] )
    redirect_to(
      edit_admin_podcast_path( @podcast )
    )
  end

  def edit
    @podcast = Podcast.find( params[:id] )
  end

  def update
    @podcast = Podcast.find( params[:id] )

    if @podcast.update( podcast_params )
      redirect_to(
        admin_podcasts_path,
        flash: {
          success: "You updated the \"#{@podcast.title}\" podcast. "
        }
      )
    else
      render :edit
      flash.now[:error] = "Something went wrong! Try again."
    end
  end

  private

  def podcast_params
    params.require( :podcast ).permit(
      :description,
      :main_image,
      :recording,
      :release_date,
      :secondary_image,
      :title,
      :visible
    )
  end
end
