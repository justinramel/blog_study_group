class PostsController < ApplicationController
	def new
		@post = @blog.new_post
	end

	def create
		@post = @blog.new_post(params[:post])
		if @post.publish
      redirect_to root_path, notice: "Post added!"
    else
      render "new"
    end

	end
end

