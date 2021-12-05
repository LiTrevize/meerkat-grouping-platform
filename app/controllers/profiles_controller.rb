class ProfilesController < SessionsController
  before_action :check_current_user

  def new
  end

  def create
    @profile = @current_user.create_profile(profile_info)
    session[:uid] = @current_user.id
    redirect_to root_path
  end

  def update
    @profile = Profile.find(params[:id])
    @profile.update_attributes(profile_info)
    redirect_to posts_path
  end

  def show_member
    member = User.find(params[:user_id])
    groups = GroupUser.where(user_id: @current_user.id, status: :accepted)
    is_member = false
    groups.each do |group|
      if GroupUser.where(group_id: group.id, user_id: member.id, status: :accepted)
        is_member = true
        break
      end
    end
    if is_member
      @profile = Profile.find_by_user_id(member.id)
      @user = member
    else
      redirect_back(fallback_location: posts_path)
    end
  end

  def show
    @profile = Profile.find_by_user_id(@current_user.id)
    # my groups
    @groups = GroupUser.where(user_id: @current_user.id, status: [:accepted, :dismissed])
    @groups.each do |group_user|
      add_attribute(group_user, :title)
      group = Group.find(group_user.group_id)
      post = Post.find_by_id(group.post_id)
      if post
        group_user.title = post.title
      end
    end
    # my pending action
    # approve or reject
    hosted = GroupUser.where(user_id: @current_user.id, is_host: true)
    @pendings = []
    hosted.each do |host_group_user|
      group_user = GroupUser.where(group_id: host_group_user.group_id, status: :applied).where.not(user_id: @current_user.id).first
      if not group_user or group_user.status == :deleted
        next
      end
      group = Group.find(group_user.group_id)
      post = Post.find_by_id(group.post_id)
      if not post
        next
      end
      add_attribute(group_user, :title)
      group_user.title = post.title
      add_attribute(group_user, :post_id)
      group_user.post_id = post.id
      @pendings.push(group_user)
    end
    # applied
    @applied = GroupUser.where(user_id: @current_user.id, is_host: false, status: [:applied, :approved, :rejected])
    @applied.each do |group_user|
      add_attribute(group_user, :title)
      add_attribute(group_user, :post_id)
      group = Group.find(group_user.group_id)
      post = Post.find_by_id(group.post_id)
      if not post
        next
      end
      group_user.title = post.title
      group_user.post_id = post.id
    end
  end

  def profile_info
    params.require(:profile).permit(:school, :degree, :major)
  end

  #private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  #def profile_params
    #ret = params.require(:profile).permit(:major)
    #ret[:user_id] = @current_user.id
    #ret
  #end

end