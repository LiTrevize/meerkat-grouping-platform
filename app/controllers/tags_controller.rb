class TagsController < SessionsController
    before_action :check_current_user

    def new
      @tag = Tag.new
    end
    
    def create
        @tag= @current_user.create_tag(tag_info)
        session[:uid] = @current_user.id
        redirect_to root_path
    end
    
    def tag_info
        params.require(:tag).permit(:name)
    end
  
  end
  