require 'rails_helper'


describe ProfilesController do
  render_views

  before :each do
    @user = User.create(:id => 1, :name => 't1', :email => 't1@columbia.edu' )

  end
  

  describe "test update profile" do
    it 'calls the model method that update profile' do
      @tmp_profile = Profile.create(:user_id => @user.id, :school => 'seas', :degree => 'bs', :major => 'cs' )
      url = "/profile/#{@tmp_profile.id}"
      put :update, params: { profile: {degree: "ms"}, id: @tmp_profile.id}

      new_profile = Profile.find_by_user_id(@user.id)
      expect(new_profile.degree).to eq 'ms'
      # profile.find_by_user_id
    end
  end

  describe "test show profile" do
    it 'calls the model method that show profile' do
      @tmp_profile = Profile.create(:user_id => @user.id, :school => 'seas', :degree => 'bs', :major => 'cs' )

      @tmp_profile.school = "art"
      @tmp_profile.save
      get :show
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      expect(response.body).to include("art")
    end
  end

  describe "test new profile" do
    it 'calls the model method that direct to new profile' do
      @tmp_profile = Profile.create(:user_id => @user.id, :school => 'seas', :degree => 'bs', :major => 'cs' )
      get :new
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
      expect(response.body).to include("school")
      expect(response.body).to_not include("art")
    end
  end


  describe "test create profile" do
    it 'calls the model method that direct to create profile' do
      get :new
      post :create, params: { profile: {:school => 'art', :degree => 'bs', :major => 'photo' }}
      new_profile = Profile.find_by_user_id(1)
      expect(new_profile.major).to eq 'photo'
    end
  end

end