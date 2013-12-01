class PostsController < ApplicationController

before_action :set_post, only: [:show, :edit, :update, :vote]
before_action :check_login, except: [:index, :show]


def index
	@posts = Post.all
end

def show
	@comment = Comment.new()
end

def new
	@post = Post.new
end

def create
	@post = Post.new(post_params)
	@post.user = current_user

	if @post.save
		flash[:notice] = "Your post was successfully saved"
		redirect_to posts_path
	else
		render :new
	end
end

def edit
end

def update

	if @post.update(post_params)
		flash[:notice] = "Your post was successfully updated"
		redirect_to posts_path
	else
		render :edit
	end
end

def vote
	@vote = Vote.create(vote: params[:vote], user: current_user, voteable: @post)

	respond_to do |format|
		format.html { redirect_to :back, notice: "Your vote was successfully saved"}
		format.js 
	end

end


private

def post_params
	params.require(:post).permit(:title, :url, :description, category_ids: [])
end

def set_post
	@post = Post.find(params[:id])
end

end
