class GroupsController < PostsController
  before_action :check_current_user

  def apply
    if is_owner?
      flash[:msg] = 'Cannot apply to your own group'
    else
      group_user = GroupUser.create(group_id: params[:id], user_id: @current_user.id, status: :applied)
      flash[:msg] = 'Group applied' 
    end
    redirect_back(fallback_location: posts_path)
  end
  
  def approve
    if not is_owner?
      puts "this is post_user id in approve"
      puts Post.find(params[:id]).user_id
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

  protected
  def is_owner?
    post_id=Group.find(params[:id]).post.id
    return Post.find(post_id).user_id == @current_user.id
    #return Post.find(params[:id]).user_id == @current_user.id
  end

end
  