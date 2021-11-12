class GroupsController < PostsController
  before_action :check_current_user

  def apply
    if is_owner?
      flash[:msg] = 'Cannot apply to your own group'
    else
      group_user = GroupUser.create(group_id: sessions[:id], user_id: @current_user.id, status: :apply)
      flash[:msg] = 'Group applied'
    end
    redirect_back(fallback_location: posts_path)
  end

  def accept
    group_user = GroupUser.where(group_id: sessions[:id], user_id: @current_user.id).first
    group_user.update(status: :accepted)
    redirect_back(fallback_location: posts_path)
  end

  protected
  def is_owner?
    return Post.find(sessions[:id]).user.id == @current_user.id

end