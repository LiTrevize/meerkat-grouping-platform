# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create!(name: 'Debug', email: 'debug@columbia.edu')
user1 = User.create!(name: 'Debug1', email: 'debug1@columbia.edu')
user2 = User.create!(name: 'Debug2', email: 'debug2@columbia.edu')


profile = Profile.create!(user_id: user.id, school: 'SEAS', degree: 'MS', major: 'CS')
post = Post.create!(user_id: user.id, title: '4995 SAAS Project Team', content: "I would like to find teammates for Project Meerkat.")
group=Group.create(post_id: post.id)
#test_approved_wq=GroupUser.create!(group_id: group.id, user_id: 1, status: :approved)

#post2=Post.create!(user_id: 1, title: 'WQ host', content: "This is create by wq")
#group2=Group.create(post_id: post2.id)
#test_group_user1=GroupUser.create!(group_id: group2.id, user_id: user1.id, status: :applied)
#test_group_user2=GroupUser.create!(group_id: group2.id, user_id: user2.id, status: :applied)

Comment.create!(post_id: post.id, content: "What tech stack will you use?", is_public: true)
Comment.create!(post_id: post.id, content: "Ruby on Rails", is_public: true)