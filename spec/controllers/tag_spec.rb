require 'rails_helper'


describe PostsController do
  render_views

  before :each do
    @user = User.create!(:id => 1, :name => 't1', :email => 't1@columbia.edu' )
    @tag = Tag.create(name:"ab", freq: 0)
    @tag = Tag.create(name:"bc", freq: 0)

    @tag1 = Tag.create!(name: "tag_a", freq: 10)
    @tag2 = Tag.create!(name: "tag_b", freq: 1)
    @tag3 = Tag.create!(name: "tag_c", freq: 12)

    @test_post = Post.create!(:user_id => @user.id, :title => 'test_post', :content => 'hello', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
    @test_post_tags_1 = PostTag.create(:post_id => @test_post.id, :tag_name => @tag1.name)
    @test_post_tags_2 = PostTag.create(:post_id => @test_post.id, :tag_name => @tag2.name)
    @test_post_tags_3 = PostTag.create(:post_id => @test_post.id, :tag_name => @tag3.name)

  end
 
  
  describe "test new posts with tags" do
    it 'calls the model method that direct to new profile' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response).to render_template :index
      expect(response.body).to include("ab")
      expect(response.body).to include("bc")

    end
  end


  describe "select tags" do
    it 'hide tags' do
      # post :approve, params: {id: test_approve_group2.id, user_id: test_applican1.id}
      tmp_hash = { @tag1.name => 1, @tag2.name => 1}
      get :index, params: {tagnames: tmp_hash}
      expect(response.body).to include 'tag_a'
      expect(response.body).to include 'tag_b'
    end
  end
   


      
  describe "update tags" do
    it "with new tags" do
      test_tag_hash = {1 => "tag_a", 2 => "tag_e", 3 => ""}
      put :update, params: {id: @test_post.id, tags: test_tag_hash, post: {title:'t1', content:'t2', start:"01-01-2022", end:"01-02-2023", low_number:'2', high_number:'3'}}
      expect(PostTag.where(post_id: @test_post.id, tag_name: "tag_a").first).not_to be_nil
      expect(PostTag.where(post_id: @test_post.id, tag_name: "tag_e").first).not_to be_nil
      expect(PostTag.where(post_id: @test_post.id, tag_name: "tag_b").first).to be_nil
    end

    it "with no tags" do
      @test_post2 = Post.create!(:user_id => @user.id, :title => 'test_post2', :content => 'hello2', start: "01/01/2022", end: "01/02/3022", low_number: 1, high_number: 3)
      test_tag_hash_2 = {1 => "", 2 => "", 3 => ""}
      put :update, params: {id: @test_post2.id, tags: test_tag_hash_2, post: {title:'test_post2', content:'hello2', start:"01-01-2021", end:"01-02-2022", low_number:'2', high_number:'3'}}
      expect(PostTag.where(post_id: @test_post2.id, tag_name: "other").first).not_to be_nil

    end

end



end