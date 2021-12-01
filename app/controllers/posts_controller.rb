class PostsController < SessionsController
  before_action :check_current_user

  def index
    @tags = Tag.all.order(freq: :desc)
    @tags_to_show = []
    tagnames = params[:tagnames]
    if tagnames
      @tags_to_show = tagnames.keys
      post_tags = PostTag.where(tag_name: tagnames.keys)
      @posts = []
      post_tags.each do |post_tag|
        @posts.append(Post.find(post_tag.post_id))
      end
    else
      @posts = Post.all
    end
  end
  
  def new
  end

  def show
    @post = Post.find(params[:id])
    @group = @post.group
    # comments
    @comments = Comment.where(post_id: params[:id], to_comment_leader_id: nil).order(:created_at)
    @comments.each do |comment|
      add_attribute(comment, :from_nickname)
      comment.from_nickname = update_nickname(@post, comment.from_user_id)
      add_attribute(comment, :to_nickname)
      comment.to_nickname = update_nickname(@post, comment.to_user_id)
      add_attribute(comment, :subs)
      comment.subs = []
      subs = Comment.where(post_id: params[:id], to_comment_leader_id: comment.id).order(:created_at)
      subs.each do |sub|
        add_attribute(sub, :from_nickname)
        sub.from_nickname = update_nickname(@post, sub.from_user_id)
        add_attribute(sub, :to_nickname)
        sub.to_nickname = update_nickname(@post, sub.to_user_id)
        comment.subs.push(sub)
      end
    end
    @to_comment_id = params[:to_comment_id]
    @to_user_id = params[:to_user_id]
    # application status
    @all_members = []
    GroupUser.where(group_id: @post.group.id, status: :accepted).each do |groupuser|
      @all_members.push(User.find(groupuser.user_id))
    end
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
    post = @current_user.posts.create(post_info)
    if post
      # tag
      update_tags(post)
      # group
      group = Group.create
      post.group = group
      # group.id=post.id
      post.save
      GroupUser.create(group_id: group.id, user_id: @current_user.id, is_host: true, status: :accepted)
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    update_tags(@post)
    @post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
    @tags = TagStruct.new
    @post.tags.each_with_index do |tag, idx|
      key = "tag#{idx+1}"
      # @tags.key = tag.name
      @tags.send("#{key}=", tag.name)
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_info)
    update_tags(@post)
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

  def update_tags(post)
    post.tags.each do |tag|
      tag.freq -= 1
      if tag.freq == 0
        tag.destroy
      else
        tag.save
      end
    end
    post.post_tags.destroy_all
    if params[:tags]
      params[:tags].each do |_, name|
        if not name.blank?
          tag = Tag.find_or_create_by!(name: name)
          post.tags.append(tag)
          tag.update(freq: tag.freq + 1)
        end
      end
      # puts '#######'
      # puts post.tags
      # puts post.tags.length
      if post.tags.length == 0
        tag = Tag.find_or_create_by!(name: 'other')
        post.tags.append(tag)
        tag.update(freq: tag.freq + 1)
      end
    end
    post.save
  end

  class TagStruct
    attr_accessor :tag1, :tag2, :tag3, :tag4, :tag5
  end
  
end
