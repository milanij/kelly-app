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
      render :index
      flash.now[:success] = "You created your post."
    else
      render :new
      flash.now[:error] = "Something went wrong! Try again."
    end
  end

  def edit
    @post = Post.find( params[:id] )
  end

  def update
    @post = Post.find( params[:id] )

    if @post.save(post_params)
      redirect_to(
        admin_posts_path,
        flash: { success: "You updated your post." }
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
      :date,
      :main_image,
      :secondary_image,
      :title,
      :visible
    )
  end
end
