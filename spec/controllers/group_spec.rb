require 'rails_helper'

describe GroupsController do
  render_views

  before :each do
    @user = User.create!(:name => 't1', :email => 't1@columbia.edu' )
    @test_post = Post.create!(:user_id => @user.id, :title => 'test_post', :content => 'hello', start: '01/01/2022', end: '01/02/2022')
    @test_group = Group.create!(post_id: @test_post.id)
  end
  
  describe "send group chat" do 
    it "succeed with a group member" do
      post :send_chat, params: {id: @test_group.id, msg: {text: 'hello'}}
      chat = GroupChat.find_by_text('hello')
      expect(chat).to be_truthy
    end

    it "fails for non group member" do
      new_user = User.create!(name: 't2')
      new_post = Post.create!(user_id: new_user.id, end: '01/02/2022')
      new_group = Group.create!(post_id: new_post.id)
      post :send_chat, params: {id: new_group.id, msg: {text: 'hello'}}
      chat = GroupChat.find_by_text('hello')
      expect(chat).to be_nil
    end
  end

  describe "show group chat" do
    it "succeed showing history group chat" do
      chat = GroupChat.create!(text: 'hello', group_id: @test_group.id, user_id: @user.id)
      get :show, params: {id: @test_group.id}
      expect(response).to render_template(:show)
      expect(response.body).to include 'hello'
    end 
  end
end