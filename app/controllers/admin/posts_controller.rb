class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
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
      render :new
      flash.now[:error] = "Something went wrong! Try again."
    end
  end

  def show
    @post = Post.find( params[:id] )
    redirect_to(
      admin_edit_post_path( @post )
    )
  end

  def edit
    @post = Post.find( params[:id] )
  end

  def update
    @post = Post.find( params[:id] )

    if @post.update(post_params)
      redirect_to(
        admin_posts_path,
        flash: {
          success: "You created the \"#{@post.title}\" post. "
        }
      )
    else
      render :edit
      flash.now[:error] = "Something went wrong! Try again."
    end
  end

  private

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
