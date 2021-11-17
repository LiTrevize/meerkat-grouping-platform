require 'rails_helper'

describe PostsController do
  controller do

  end

  before :each do
    @user = User.create!(:name => 't1', :email => 't1@columbia.edu' )
    @test_post = Post.create!(:user_id => @user.id, :title => 'test_post', :content => 'hello', :tag1 => 'ab', :tag2 => 'bc',:tag3 => 'de')
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
        expect(@test_post.next_nickname_id).to eq old_id+1
      end
  end
    
#   describe "test private comment" do
#       it "creates private comment" do
#           post :create, params: {id: @test_post.id, from_user_id: @from_user.id, to_user_id: @to_user.id, to_comment: {id: @test_comment.id, content: "test"}, is_public:nil}
#       end 
#   end 
    
end