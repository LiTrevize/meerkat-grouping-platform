class CommentsController < PostsController
    before_action :check_current_user
    
    def create
        post = Post.find(params[:id])
        is_public = params[:is_public]
        if is_public == nil
            is_public = false
        end
        to_comment_id = params[:to_comment][:id]
        if not to_comment_id
            to_comment_id = nil
        end
        comment = post.comments.create(content: params[:to_comment][:content], from_user_id: @current_user.id, to_comment_id: to_comment_id, is_public: is_public)
        redirect_to post_path(post)
    end
    
    def destroy    
    end
    
    private
    
#     def comment_info
#         params.require(:comment).permit(:from_user, :content)
#     end

end