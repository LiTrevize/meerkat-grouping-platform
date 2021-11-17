require 'rails_helper'

describe CommentsController do
  before :each do
    @from_user = User.create(:name => 't123', :email => 't123@columbia.edu' )
    @to_user = User.create(:name => 't234', :email => 't234@columbia.edu' )
    @to_user2 = User.create(:name => 't235', :email => 't235@columbia.edu' )
    @test_post = Post.create(:user_id => @from_user.id, :title => 'test_post', :content => 'hello')
    
    
  end
    
  describe "test create comment" do
      it "successfully create" do
          test_comment = Comment.create(:post_id=>@test_post.id, :content => 'test test', :from_user_id => @from_user.id, :to_user_id => @to_user.id, 
          :to_comment_id => '', :is_public => true)
          post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: test_comment.id, content: "test"}, is_public:true}
          new_comment = Comment.find_by_content('test')
          expect(new_comment.content).to eq 'test'
      end
      it "automatically set is_public" do
          test_comment2 = Comment.create(:post_id=>@test_post.id, :content => 'no', :from_user_id => @from_user.id, :to_user_id => @to_user2.id, 
          :to_comment_id => '',:is_public => false)
          post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: test_comment2.id, content: "no"}, is_public:true}
          new_comment2 = Comment.find_by_content('no')
          expect(new_comment2.is_public).to eq false
      end 
      
  end
    
#   describe "test private comment" do
#       it "creates private comment" do
#           post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: @test_comment.id, content: "test"}, is_public:nil}
#       end 
#   end 
    
end