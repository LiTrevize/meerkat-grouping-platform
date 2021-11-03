require 'rails_helper'

# describe User do
#     user_id = -1
#     it "should put the user info" do
#       user = User.create(:name => 't1', :email => 't1@columbia.edu' )
#       user_id = user.id
#       #   puts user.id
#       expect(user.name).to eq('t1')
#       expect(user.email).to eq('t1@columbia.edu')
#     end
    
    

#     describe "profile test" do
#         # puts "hi!!!!~!"
#         hi = Profile.create(:school => 'seas', :degree => 'bs', :major => 'cs' )
#         it "create new profile" do
#           expect(hi.school).to eq('seas')
#           expect(hi.degree).to eq('bs')
#           expect(hi.major).to eq('cs')
#         end
#         # it "update the infor" do 
          
        
#     end
#   end
# it 'selects the Search Results template for rendering'
# it 'makes the TMDb search results available to that 
# template'

describe ProfilesController do
  render_views
  
  before :each do
    # User.where(id: 1).first_or_initialize do |user|
    #   user.name = 't1'
    #   user.email = 't1@columbia.edu'
    # end
    @user = User.create(:id => 1, :name => 't1', :email => 't1@columbia.edu' )
    @tmp_profile = Profile.create(:user_id => @user.id, :school => 'seas', :degree => 'bs', :major => 'cs' )
  end
  
  # describe "create profile" do
  #   it 'calls the model method that create profile' do
  #     url = "/profile/"
  #     post :create, params: { profile: {degree: "ms", school: "seas"}}

  #     new_profile = Profile.find_by_user_id(@user.id)
  #     expect(new_profile.degree).to eq 'ms'
  #     # profile.find_by_user_id
  #   end
  # end
  describe "test update profile" do
    it 'calls the model method that update profile' do
      url = "/profile/#{@tmp_profile.id}"
      put :update, params: { profile: {degree: "ms"}, id: @tmp_profile.id}

      new_profile = Profile.find_by_user_id(@user.id)
      expect(new_profile.degree).to eq 'ms'
      # profile.find_by_user_id
    end
  end

  describe "test show profile" do
    it 'calls the model method that create profile' do
      # tmp_show_profile = Profile.find_by_user_id(1)
      @tmp_profile.school = "art"
      @tmp_profile.save
      # put :update, params: { profile: {school: "art"}, id: @tmp_profile.id}
      get :show
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
      # puts(response.body)
      expect(response.body).to include("art")

      # profile.find_by_user_id
    end
  end
end