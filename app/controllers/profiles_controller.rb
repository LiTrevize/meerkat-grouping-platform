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

  def show
    @profile = Profile.find_by_user_id(@current_user.id)
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