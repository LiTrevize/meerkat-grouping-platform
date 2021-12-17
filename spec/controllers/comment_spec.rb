require 'rails_helper'

describe CommentsController do
  before :each do
    @from_user = User.create(:name => 't123', :email => 't123@columbia.edu' )
    @to_user = User.create(:name => 't234', :email => 't234@columbia.edu' )
    @to_user2 = User.create(:name => 't235', :email => 't235@columbia.edu' )
    @test_post = Post.create(:user_id => @from_user.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
    
    
  end
    
  describe "test create comment" do
      it "successfully" do
          # test_comment = Comment.create(:post_id=>@test_post.id, :content => 'test test', :from_user_id => @from_user.id, :to_user_id => @to_user.id, :to_comment_id => '', :is_public => true)
          post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {content: "test"}, is_public:true}
          new_comment = Comment.find_by_content('test')
          expect(new_comment).not_to be_nil
      end

      it "that reply to another comment" do
        test_comment = Comment.create(:post_id=>@test_post.id, :content => 'test test', :from_user_id => @from_user.id, :to_user_id => @to_user.id, :is_public => true)
        post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: test_comment.id, leader_id: test_comment.id, content: "reply_comment"}, is_public:true}
        new_comment = Comment.find_by_content('reply_comment')
        expect(new_comment.content).not_to be_nil
      end
      
  end
    
#   describe "test private comment" do
#       it "creates private comment" do
#           post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: @test_comment.id, content: "test"}, is_public:nil}
#       end 
#   end 
    
end