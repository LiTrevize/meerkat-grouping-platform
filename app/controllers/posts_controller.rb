class PostsController < SessionsController
  before_action :check_current_user

  def index
    @posts = Post.all
    @tags = Tag.all
  end
  
  def new
  end

  def show
    @post = Post.find(params[:id])
    # comments
    @comments = Comment.where(post_id: params[:id]).order(:created_at)
    @comments.each do |comment|
      add_attribute(comment, :from_nickname)
      comment.from_nickname = update_nickname(@post, comment.from_user_id)
      add_attribute(comment, :to_nickname)
      comment.to_nickname = update_nickname(@post, comment.to_user_id)
    end
    @to_comment_id = params[:to_comment_id]
    @to_user_id = params[:to_user_id]
    # application status
    @all_applied_user=GroupUser.where(group_id: @post.group.id, status: :applied)
    @all_approved_user=GroupUser.where(group_id: @post.group.id, status: :approved)   
    current_group_user=GroupUser.where(group_id: @post.group.id,user_id: @current_user.id).first
    
    @applied_user_name = []
    @approved_user_name = []   
    @approve_url=[]
    @reject_url=[]
    
    for applied_user in @all_applied_user do
      this_user=User.find(applied_user.user_id)
      @applied_user_name.append(this_user.name)
      this_approve="/post/#{@post.group.id}/approve/#{applied_user.user_id}"
      @approve_url.append(this_approve)     
      this_reject="/post/#{@post.group.id}/reject/#{applied_user.user_id}"
      @reject_url.append(this_reject)
    end
    
    for approved_user in @all_approved_user do
      this_user=User.find(approved_user.user_id)
      @approved_user_name.append(this_user.name)
    end 
    
    if current_group_user == nil 
      @current_group_user_status= "You haven't applied for this Group"
    else
      @current_group_user_status=current_group_user.status     
    end
  end
  
  def create

    tag_name_list = Array[post_info[:tag1], post_info[:tag2], post_info[:tag3]]
    # puts tag_name_list
    # puts 'HI!!!!!!!'

    tag_name_list.each do |tag_name|

      if tag_name == ""
        tag_name = "other"
      end
      # puts tag_name
      tmp_tag = Tag.find_by(name: tag_name)
      if tmp_tag == nil
        tmp_tag = Tag.create(name: tag_name, freq: 0)
      end
    
    end
 
    post = @current_user.posts.create(post_info)
    if post
      # group
      group = Group.create
      post.group = group
      # group.id=post.id
      # post.update(tag1: tmp_tag.name)
      post.update(tag1: tag_name_list[0],tag2: tag_name_list[1],tag3: tag_name_list[2])
      post.save
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
    params.require(:post).permit(:title, :content, :start, :end, :low_number, :high_number, :tag1, :tag2, :tag3)
  end

  def get_nickname(id)
    cnt = Nickname.count
    name = Nickname.find(((id-1)%cnt)+1).name
    if (id-1)/cnt>0
      name += '.' + (id/cnt).to_s
    end
    return name
  end

  def update_nickname(post, user_id)
    if user_id == nil or user_id == ""
      return nil
    end
    if post.user_id == user_id
      return "Host"
    end
    nickname_id = nil
    assoc = PostUserNickname.find_by(post_id: post.id, user_id: user_id)
    if not assoc
      PostUserNickname.create(post_id: post.id, user_id: user_id, nickname_id: post.next_nickname_id)
      nickname_id = post.next_nickname_id
      post.next_nickname_id += 1
      post.save
    else
      nickname_id = assoc.nickname_id
    end
    return get_nickname(nickname_id)
  end

  def add_attribute(klass, symbol)
    codes = %Q{
      def #{symbol}
        return @#{symbol}
      end
      def #{symbol}=(value)
        @#{symbol} = value
      end
    }

    klass.instance_eval(codes)
  end
  
end
