require 'rails_helper'


describe PostsController do
  render_views

  before :each do
    @user = User.create!(:id => 1, :name => 't1', :email => 't1@columbia.edu' )
    @tag = Tag.create(name:"ab", freq: 0)
    @tag = Tag.create(name:"bc", freq: 0)
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