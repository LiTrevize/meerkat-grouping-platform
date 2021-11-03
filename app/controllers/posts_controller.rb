class PostsController < SessionsController
  before_action :check_current_user

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    if @current_user.posts.create(post_info)
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_info)
    redirect_to posts_path
  end
  
  private
  
  def post_info
    params.require(:post).permit(:title, :content)
  end

end
