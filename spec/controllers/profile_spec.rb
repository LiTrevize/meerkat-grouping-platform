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
  before :each do
    @user = User.create(:name => 't1', :email => 't1@columbia.edu' )
    @tmp_profile = Profile.create(:user_id => @user.id, :school => 'seas', :degree => 'bs', :major => 'cs' )
  end

  describe "test profile" do
    it 'calls the model method that update profile' do
      url = "/profile/#{@tmp_profile.id}"

      put :update, params: { profile: {degree: "ms"}, id: @tmp_profile.id}

      new_profile = Profile.find_by_user_id(@user.id)
      expect(new_profile.degree).to eq 'ms'
      # profile.find_by_user_id

    end
  end
end