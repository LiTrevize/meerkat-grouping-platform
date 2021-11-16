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
        to_user_id = nil
        to_comment = Comment.find_by(id: to_comment_id)
        if to_comment
            to_user_id = to_comment.from_user_id
        end
        comment = post.comments.create(content: params[:to_comment][:content], from_user_id: @current_user.id, to_user_id: to_user_id, to_comment_id: to_comment_id, is_public: is_public)
        update_nickname(post, @current_user.id)
        redirect_to post_path(post)
    end
    
    private
    
#     def comment_info
#         params.require(:comment).permit(:from_user, :content)
#     end

end