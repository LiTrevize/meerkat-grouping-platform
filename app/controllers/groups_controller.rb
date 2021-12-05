class GroupsController < PostsController
  before_action :check_current_user
  before_action -> { check_group_dismissal false }, only: [:show]
  before_action -> { check_group_dismissal true }, only: [:send_chat]

  def apply
    if is_owner?
      flash[:msg] = 'Cannot apply to your own group'
    else
      group_user = GroupUser.create(group_id: params[:id], user_id: @current_user.id, status: :applied, intro: params[:applyuser][:intro])
      flash[:msg] = 'Please wait for the host to review your group application'
    end
    redirect_back(fallback_location: posts_path)
  end
  
  def approve
    if not is_owner?
      flash[:msg] = "Only owner can process applications #{Post.find(params[:id]).user.id}"
    else   
      group_user = GroupUser.where(group_id: params[:id], user_id: params[:user_id]).first
      group_user.update(status: :approved)
    end
    redirect_back(fallback_location: posts_path)
  end

  def reject
    if not is_owner?
      flash[:msg] = 'Only owner can process applications'
    else
      group_user = GroupUser.where(group_id: params[:id], user_id: params[:user_id]).first
      group_user.update(status: :rejected)
    end
    redirect_back(fallback_location: posts_path)
  end

  def accept
    group_user = GroupUser.where(group_id: params[:id], user_id: @current_user.id).first
    group_user.update(status: :accepted)
    flash[:msg]="Invitation accepted"
    redirect_back(fallback_location: posts_path)
    
  end

  def refuse
    group_user = GroupUser.where(group_id: params[:id], user_id: @current_user.id).first
    group_user.update(status: :refused)
    flash[:msg]="Invitation refused"
    redirect_back(fallback_location: posts_path) 
  end

  def show
    @group = Group.find(params[:id])
    if is_member?
      group_users = GroupUser.where(group_id: @group.id, status: :accepted)
      ids = []
      group_users.each do |group_user|
        ids.push(group_user.user_id)
      end
      @members = User.where(id: ids)
      # @group_chats = GroupChat.where(group_id: @group.id).order(created_at: :desc).limit(10).reverse_order
      @group_chats = GroupChat.where(group_id: @group.id).order(created_at: :asc)
      @group_chats.each do |chat|
        add_attribute(chat, :user_name)
        chat.user_name = User.find(chat.user_id).name
      end
    else
      flash[:msg] = "You have not joined the group, only group members can access the group chat"
      redirect_to post_path(@group.post)
    end
  end

  def send_chat
    group = Group.find(params[:id])
    if not is_member?
      redirect_to post_path(group.post)
    else
      chat = GroupChat.create(group_id: group.id, text: params[:msg][:text], user_id: @current_user.id)
      redirect_to group_path(group)
    end
  end
  
  protected
  def is_owner?
    post_id=Group.find(params[:id]).post.id
    return Post.find(post_id).user_id == @current_user.id
  end

  def is_member?
    groupusers = GroupUser.where(group_id: params[:id], user_id: @current_user.id, status: :accepted)
    group = Group.find(params[:id])
    if groupusers.length>0 or group.post.user_id==@current_user.id
      return true
    else
      return false
    end
  end

  def check_group_dismissal(back)
    group = Group.find(params[:id])
    if group.dismissed or Post.find(group.post_id).end < Date.today
      group.update(dismissed: true)
      flash[:msg] = "This group is dismissed. You can only view history chats."
      if back
        redirect_back(fallback_location: posts_path) 
      end
    end
  end

end
  