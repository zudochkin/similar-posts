class PostsController < ApplicationController
  respond_to :html, :json
  
  def index
    @posts = Post.search params[:q]
  end

  def edit
    @post = Post.find params[:id]
  end

  def update
    @post = Post.find params[:id]
    if @post.update_attributes params[:post]
      redirect_to @post
    else
      render :edit
    end
  end

  def show
    @post = Post.find params[:id]
  end
end
