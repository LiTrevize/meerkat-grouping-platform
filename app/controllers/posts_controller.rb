class PostsController < SessionsController

  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_info)
    
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end
  
  private
  
  def post_info
    info.require(:post).permit(:title, :content)
  end

end
