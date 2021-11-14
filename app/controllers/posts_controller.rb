class PostsController < SessionsController
  before_action :check_current_user

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: params[:id]).order(:created_at)
    @to_comment_id = params[:to_comment_id]
    @to_user_id = params[:to_user_id]
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
