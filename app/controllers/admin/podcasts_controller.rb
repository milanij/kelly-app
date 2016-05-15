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
      errors = @podcast.errors.full_messages.join(", ")
      flash.now[:error] = "Something went wrong!\n"\
                          "Check these: #{errors}"
      render :new
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
          success: "You updated the \"#{@podcast.title}\" podcast."
        }
      )
    else
      errors = @podcast.errors.full_messages.join(", ")
      flash.now[:error] = "Something went wrong!\n"\
                          "Check these: #{errors}"
    end
  end

  private

  def podcast_params
    params.require( :podcast ).permit(
      :description,
      :hashtag,
      :main_image,
      :recording_url,
      :release_date,
      :secondary_image,
      :title,
      :visible
    )
  end
end
