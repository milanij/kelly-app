class Admin::PostsController < ApplicationController

  def index
    @posts = Post.all.order( "created_at DESC" )
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new

    if @post.create(post_params)
      render :new
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
      render :edit
      flash.now[:success] = "You updated your post."
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
