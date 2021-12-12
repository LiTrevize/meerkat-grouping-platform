require 'rails_helper'

describe GroupsController do
   before :each do
    @user = User.create(:name => 't1', :email => 't1@columbia.edu' )
   end
  
  describe "user can apply for group" do 
    it "change user status to applied" do
      test_host=User.create(:name => 'test_host1', :email => 'h1@columbia.edu' )
      test_apply_post = Post.create(:user_id => test_host.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_apply_group=Group.create(:post_id=>test_apply_post.id)
      url = "/post/#{test_apply_group.id}"
      post :apply, params: {id: test_apply_group.id, applyuser: {intro: 'I m intro.'}}
      after_apply=GroupUser.where(:group_id=>test_apply_group.id, :user_id=>@user.id).first
      expect(after_apply.status).to eq("applied")
    end
    it "cannot apply to your own group" do
      test_apply_post = Post.create(:user_id => @user.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_apply_group=Group.create(:post_id=>test_apply_post.id)
      url = "/post/#{test_apply_group.id}"
      post :apply, params: {id: test_apply_group.id}
      expect(flash[:msg]).to eq('Cannot apply to your own group')
    end
  end 
  
  describe "after user's group application is approved" do 
    it "can accept group incitation" do
      test_host2=User.create(:name => 'test_host2', :email => 'h2@columbia.edu' )
      test_approve_post = Post.create(:user_id => test_host2.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_approve_group=Group.create(:post_id=>test_approve_post.id)
      test_approve_group_user=GroupUser.create(:group_id=>test_approve_group.id, :user_id=>@user.id, :status=>"approved") 
      post :accept, params: {id: test_approve_group.id}
      after_apply=GroupUser.where(:group_id=>test_approve_group.id, :user_id=>@user.id).first
      expect(after_apply.status).to eq("accepted")
    end
    
    it "can refuse group invitation" do
      test_host2=User.create(:name => 'test_host2', :email => 'h2@columbia.edu' )
      test_approve_post = Post.create(:user_id => test_host2.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_approve_group=Group.create(:post_id=>test_approve_post.id)
      test_approve_group_user=GroupUser.create(:group_id=>test_approve_group.id, :user_id=>@user.id, :status=>"approved") 
      post :refuse, params: {id: test_approve_group.id}
      after_apply=GroupUser.where(:group_id=>test_approve_group.id, :user_id=>@user.id).first
      expect(after_apply.status).to eq("refused")
    end    
  end 
  
  describe "user creates a group and this group has some applications" do
    it "can approve application" do
      test_approve_post2 = Post.create(:user_id => @user.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_approve_group2=Group.create(:post_id=>test_approve_post2.id)
      test_applican1=User.create(:name => 'test_applican1', :email => 'ta1@columbia.edu')
      test_applied_user1=GroupUser.create(:group_id=>test_approve_group2.id, :user_id=>test_applican1.id, :status=>"applied")
      post :approve, params: {id: test_approve_group2.id, user_id: test_applican1.id}
      after_approve=GroupUser.where(:group_id=>test_approve_group2.id, :user_id=>test_applican1.id).first
      expect(after_approve.status).to eq("approved")
    end 
    
    it "can reject application" do
      test_approve_post2 = Post.create(:user_id => @user.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_approve_group2=Group.create(:post_id=>test_approve_post2.id)
      test_applican1=User.create(:name => 'test_applican1', :email => 'ta1@columbia.edu')
      test_applied_user1=GroupUser.create(:group_id=>test_approve_group2.id, :user_id=>test_applican1.id, :status=>"applied")
      post :reject, params: {id: test_approve_group2.id, user_id: test_applican1.id}
      after_approve=GroupUser.where(:group_id=>test_approve_group2.id, :user_id=>test_applican1.id).first
      expect(after_approve.status).to eq("rejected")
    end 
    
    it "only host can approve application" do
      test_host3=User.create(:name => 'test_host3', :email => 'h2@columbia.edu' )
      test_approve_post2 = Post.create(:user_id => test_host3.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_approve_group2=Group.create(:post_id=>test_approve_post2.id)
      test_applican1=User.create(:name => 'test_applican1', :email => 'ta1@columbia.edu')
      test_applied_user1=GroupUser.create(:group_id=>test_approve_group2.id, :user_id=>test_applican1.id, :status=>"applied")
      post :approve, params: {id: test_approve_group2.id, user_id: test_applican1.id}
      expect(flash[:msg]).to include("Only owner can process applications")
    end 
    
    it "only host can reject application" do
      test_host3=User.create(:name => 'test_host3', :email => 'h2@columbia.edu' )
      test_approve_post2 = Post.create(:user_id => test_host3.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_approve_group2=Group.create(:post_id=>test_approve_post2.id)
      test_applican1=User.create(:name => 'test_applican1', :email => 'ta1@columbia.edu')
      test_applied_user1=GroupUser.create(:group_id=>test_approve_group2.id, :user_id=>test_applican1.id, :status=>"applied")
      post :reject, params: {id: test_approve_group2.id, user_id: test_applican1.id}
      expect(flash[:msg]).to include("Only owner can process applications")
    end 
  end 
  
  
  
  
end