
Given /^"([^"]*)" has go to the post page$/ do |name|
  @current_user = User.create(:name=>"Test User 2", :email => "test_user2")
  puts "test user2 id: #{@current_user.id}"
  profile=Profile.create(:major=>"CS")
  profile.user=@current_user
end

Given /^Post with name "([^"]*)" is created by "([^"]*)"$/ do |name, host|
  this_user=User.create!(:name=>host, :email => "test_email")
  this_post=Post.create!(:title=>name,:content=>"#{name} content",:user_id =>this_user.id)
  Group.create!(:post_id=>this_post.id)
end

Given /^Post with name "([^"]*)" is created by "([^"]*)" and my application is approved$/ do |name, host|
  this_user=User.create!(:name=>host, :email => "test_email")
  this_post=Post.create!(:title=>name,:content=>"#{name} content",:user_id =>this_user.id)
  this_group=Group.create!(:post_id=>this_post.id)
  GroupUser.create!(:group_id=>this_group.id, :user_id=>1, :status=>"approved")
end 

Given /^I created a post with name "([^"]*)", and "([^"]*)" applied for it$/ do |post_name,name1|
  this_post=Post.create!(:title=>post_name,:content=>"#{post_name} content",:user_id =>1)
  this_group=Group.create!(:post_id=>this_post.id) 
  applied_user1=User.create!(:name=>name1, :email => "test_email1")  
  GroupUser.create!(:group_id=>this_group.id, :user_id=>applied_user1.id, :status=>"applied")
end
