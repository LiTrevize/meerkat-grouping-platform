
Given /^"([^"]*)" has go to the post page$/ do |name|
  @current_user = User.create(:name=>name, :email => "#{name}@columbia.edu")
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

Given /^I joined group for post "([^"]*)"$/ do |title|
  post = Post.find_by_title(title)
  group = Group.find_by_post_id(post.id)
  GroupUser.create(group_id: group.id, user_id: @current_user.id, status: :accepted)
end

Given /^Nicknames contain \[(.*)\]$/ do |nicknames|
  nicknames.split(',').each do |name|
    Nickname.create!(name: name)
  end
end