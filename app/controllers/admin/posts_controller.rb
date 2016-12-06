class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post

  def index
    @posts = Post.all.order( "created_at DESC" )
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to(
        admin_posts_path,
        flash: {
          success: "You created the \"#{@post.title}\" post. "
        }
      )
    else
      errors = @post.errors.full_messages.join(", ")
      flash.now[:error] = "Something went wrong!\n"\
                          "Check these: #{errors}"
      render :new
    end
  end

  def show
    redirect_to(
      admin_edit_post_path( @post )
    )
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to(
        admin_posts_path,
        flash: {
          success: "You created the \"#{@post.title}\" post. "
        }
      )
    else
      errors = @post.errors.full_messages.join(", ")
      flash.now[:error] = "Something went wrong!\n"\
                          "Check these: #{errors}"
      render :edit
    end
  end

  private

  def find_post
    @post = Post.find( params[:id] )
  end

  def post_params
    params.require( :post ).permit(
      :body,
      :description,
      :published_date,
      :main_image,
      :secondary_image,
      :title,
      :visible
    )
  end
end
