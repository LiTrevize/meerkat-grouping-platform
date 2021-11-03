Given /^"([^"]*)" is logged in$/ do |email|
  @current_user = User.create(:name=>"Test User", :email => email)
  puts "user id: #{@current_user.id}"
end

