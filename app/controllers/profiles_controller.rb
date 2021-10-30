class ProfilesController < SessionsController
  before_action :check_current_user

  def new
  end

  def create
    @profile = Profile.where(user_id: @current_user.id).first_or_initialize do |profile|
      profile.major = profile_params['major']
    end
    @profile.save
    redirect_to posts_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def profile_params
    ret = params.require(:profile).permit(:major)
    ret[:user_id] = @current_user.id
    ret
  end

end