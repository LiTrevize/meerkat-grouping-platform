require 'rails_helper'

describe User do
    user_id = -1
    it "should put the user info" do
      user = User.create(:name => 't1', :email => 't1@columbia.edu' )
      user_id = user.id
      #   puts user.id
      expect(user.name).to eq('t1')
      expect(user.email).to eq('t1@columbia.edu')
    end
    
    

    describe "profile test" do
        # puts "hi!!!!~!"
        hi = Profile.create(:school => 'seas', :degree => 'bs', :major => 'cs' )
        it "create new profile" do
          expect(hi.school).to eq('seas')
          expect(hi.degree).to eq('bs')
          expect(hi.major).to eq('cs')
        end
        # it "update the infor" do 
          
        
    end
  end

# describe profiles_controller do
#   before :each do
#     @user = User.create(:name => 't1', :email => 't1@columbia.edu' )
#     @user_id = user.id
#     tmp_profile = Profile.create(:school => 'seas', :degree => 'bs', :major => 'cs' )
#   end

#   describe Profile do
#   it 'calls the model method that update profile' do
#     url = "/profile/" + @user_id.to_s
#     put url
#     profile.find_by_user_id
#   it 'selects the Search Results template for rendering'
#   it 'makes the TMDb search results available to that 
#   template'
#   end
#   end