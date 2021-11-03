Given /^"([^"]*)" is logged in$/ do |email|
  @current_user = User.create(:name=>"Test User", :email => email)
end

