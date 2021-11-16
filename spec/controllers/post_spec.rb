require 'rails_helper'

describe PostsController do
  before :each do
    @user = User.create(:name => 't1', :email => 't1@columbia.edu' )
    @test_post = Post.create(:user_id => @user.id, :title => 'test_post', :content => 'hello', :tag1 => 'ab', :tag2 => 'bc',:tag3 => 'de')
  end
  
  describe "all posts"do 
    it "successeds" do
    get :index
    expect(response).to render_template(:index)
    end
  end 
  
  describe "test edit post" do
    it "successeds" do
    #url="/post/#{@test_post.id}"   
    get :edit, params: {id: @test_post.id}
    expect(response). to have_http_status(:success)
    end
  end 
  
  
  describe "test update post" do
    it 'calls the model method that update profile' do
      url = "/post/#{@test_post.id}"
      put :update, params: { post: {title: "Edit Post"}, id: @test_post.id}
      new_post = Post.find_by_id(@test_post.id)
      expect(new_post.title).to eq 'Edit Post'
    end
  end
  
  describe "go to new post page" do
     it "succeeds" do
         get :new
         expect(response).to have_http_status(:success)
     end
  end
  
   describe "create new post" do 
      it "successfully create" do              
          post :create, params: {post: {title: "test",content: "test"},id: 3,user_id:@user.id}
          expect(response).to redirect_to(posts_path)              
      end
   end
  
  
  describe "delete a post" do
        it "deletes a post" do
            delete :destroy, params: {id: @test_post.id}
            expect(response.body).to_not include("group project")
        end
    end

 
   
end