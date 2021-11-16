class PostsController < SessionsController
  before_action :check_current_user

  def index
    @posts = Post.all
  end
  
  def new
  end

  def show
    puts "this is user id"
    puts @current_user.id
    puts @current_user.name
    
    @post = Post.find(params[:id]) 
    @all_applied_user=GroupUser.where(group_id: @post.group.id, status: :applied)
    @all_approved_user=GroupUser.where(group_id: @post.group.id, status: :approved)   
    current_group_user=GroupUser.where(group_id: @post.group.id,user_id: @current_user.id).first
    
    @applied_user_name = []
    @approved_user_name = []   
    @approve_url=[]
    @reject_url=[]
    
    for applied_user in @all_applied_user
        this_user=User.find(applied_user.user_id)
        @applied_user_name.append(this_user.name)
        this_approve="/post/#{@post.group.id}/approve/#{applied_user.user_id}"
        @approve_url.append(this_approve)     
        this_reject="/post/#{@post.group.id}/reject/#{applied_user.user_id}"
        @reject_url.append(this_reject)
    end
    
    for approved_user in @all_approved_user
       this_user=User.find(approved_user.user_id)
       @approved_user_name.append(this_user.name)
    end 
    
    if current_group_user ==nil 
      @current_group_user_status= "You haven't applied for this Group"
    else
      @current_group_user_status=current_group_user.status     
    end
  end
  
  def create
    post = @current_user.posts.create(post_info)
    if post
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
