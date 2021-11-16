require 'rails_helper'

describe CommentsController do
  before :each do
    @from_user = User.create(:name => 't123', :email => 't123@columbia.edu' )
    @to_user = User.create(:name => 't234', :email => 't234@columbia.edu' )
    @test_comment = Comment.create(:content => 'test test', :from_user_id => @from_user.id, :to_user_id => @to_user.id, 
         :to_comment_id => '', :is_public => true)
    @test_post = Post.create(:user_id => @from_user.id, :title => 'test_post', :content => 'hello')
  end
    
  describe "test create comment" do
      it "successfully create" do
          post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: @test_comment.id, content: "test"}, is_public:true}
          new_comment = Comment.find_by_content('test')
          expect(new_comment.content).to eq 'test'
      end
  end
    
#   describe "test private comment" do
#       it "creates private comment" do
#           post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: @test_comment.id, content: "test"}, is_public:nil}
#       end 
#   end 
    
end