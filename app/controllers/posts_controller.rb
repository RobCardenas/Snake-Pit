class PostsController < ApplicationController
  before_filter :authorize, except: [:index, :show]

  # show all posts in database
 	def index
 		@posts = Post.all
 		render :index
 	end

 	# form to add posts
  def new
  	@post = Post.new
  	render :new
  end

  # form to create new post belonging to current_user
  def create
  	post = current_user.posts.create(post_params)
  	redirect_to post_path(post)
  end

  def show
  	@post = Post.find(params[:id])
  	render :show
  end

  def edit
  	@post = Post.find(params[:id])
  	if current_user.posts.include? @post
  		render :edit
  	else
  		redirect_to profile_path
  	end
  end

  def update
    post = Post.find(params[:id])
    if current_user.posts.include? post
      post.update_attributes(post_params)
      redirect_to post_path(post)
    else
      redirect_to profile_path, :notice => "Your post has been updated!"
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user.posts.include? post
      post.destroy
      redirect_to  profile_path, :notice => "Your post has been deleted"
    else
      redirect_to profile_path
    end  	
  end

  private 
  	def post_params
  		params.require(:post).permit(:title, :content)
  	end

end
