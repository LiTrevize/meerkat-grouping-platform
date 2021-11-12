class PostsController < SessionsController
  before_action :check_current_user

  def index
    @posts = Post.all
  end
  
  def new
  end

  def show
    @post = Post.find(params[:id])
  end
  
  def create
    post = @current_user.posts.create(post_info)
    if post
      #group = post.group.create
      group = Group.create
      group.id=post.id
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
    params.require(:post).permit(:title, :content, :start, :end, :low_number, :high_number)
  end

end
