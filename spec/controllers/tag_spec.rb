require 'rails_helper'


describe PostsController do
  render_views

  before :each do
    @user = User.create!(:id => 1, :name => 't1', :email => 't1@columbia.edu' )
    @tag = Tag.create(name:"ab", freq: 0)
    @tag = Tag.create(name:"bc", freq: 0)

    @tag1 = Tag.create!(name: "tag_a", freq: "10")
    @tag2 = Tag.create!(name: "tag_b", freq: "1")
    @tag3 = Tag.create!(name: "tag_c", freq: "12")

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
      puts(response.body)
      expect(response.body).to include 'tag_a'
      expect(response.body).to include 'tag_b'
    end
  end
   

  # describe "test new posts with tags" do
  #   it 'calls the model method that direct to new profile' do
  #     @tmp_post = Post.create(:tag1 => '', :tag2 => '',:tag3 => '' )
  #     get :new
  #     expect(response).to have_http_status(:ok)
  #     expect(response).to render_template(:new)
  #     expect(response.body).to include("other")
  #   end
  # end


end