require 'rails_helper'

describe PostsController do
  controller do

  end

  before :each do
    @user = User.create!(:name => 't1', :email => 't1@columbia.edu' )
    @test_post = Post.create!(:user_id => @user.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
    @test_group = Group.create!(post_id: @test_post.id)
    Nickname.create!([{name: 'Alice'},{name: 'Bob'}])
  end
    
  describe "test nickname" do
      it "get nickname by id" do
          expect(controller.send(:get_nickname, 1)).to eq 'Alice'
          expect(controller.send(:get_nickname, 2)).to eq 'Bob'
          expect(controller.send(:get_nickname, 3)).to eq 'Alice.1'
      end
      it "update nickname with host" do
        expect(controller.send(:update_nickname, @test_post, @user.id)).to eq 'Host'
      end
      it "update nickname with new user" do
        new_user = User.create!(name: 't2')
        old_id = @test_post.next_nickname_id
        expect(controller.send(:update_nickname, @test_post, new_user.id)).to eq 'Alice'
        test_comment = Comment.create!(post_id: @test_post.id, :content => 'test comment', :from_user_id => new_user.id, :to_user_id => nil, 
        :to_comment_id => nil, :is_public => true)
        expect(@test_post.next_nickname_id).to eq old_id+1
        new_user3 = User.create!(name: 't3')
        test_sub = Comment.create(:post_id=>@test_post.id, :content => 'test test', :from_user_id => new_user3.id, :to_user_id => new_user.id, 
          :to_comment_id => test_comment.id, :is_public => true)
        expect(controller.send(:update_nickname, @test_post, new_user3.id)).to eq 'Bob'
        
      end
      
  end
    
    
#   describe "test private comment" do
#       it "creates private comment" do
#           post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: @test_comment.id, content: "test"}, is_public:nil}
#       end 
#   end 
    
end