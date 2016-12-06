class Admin::PodcastsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_podcast, only: [ :show, :edit, :update ]

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
    redirect_to(
      edit_admin_podcast_path( @podcast )
    )
  end

  def edit
  end

  def update
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

  def find_podcast
    @podcast = Podcast.find( params[:id] )
  end

  def podcast_params
    params.require( :podcast ).permit(
      :description,
      :file_size,
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
