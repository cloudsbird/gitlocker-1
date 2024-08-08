class BlogsController < ApplicationController
  def index
    @blogs = Blog.page(params[:page]).per(6)
  end

  def show
    @blog = Blog.friendly.find(params[:slug])
  end
end
