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
Nickname.create([
    {name: "Alice"},
    {name: "Bob"},
    {name: "Carol"},
    {name: "David"},
    {name: "Eve"},
    {name: "Frank"},
    {name: "Ginny"},
    {name: "Henry"},
    {name: "Ivy"},
    {name: "James"},
    {name: "Kate"},
    {name: "Leo"},
    {name: "Maria"},
    {name: "Newton"},
    {name: "Oscar"},
    {name: "Peter"},
    {name: "Quita"},
    {name: "Rick"},
    {name: "Sylvie"},
    {name: "Thanos"},
    {name: "Uda"},
    {name: "Vincent"},
    {name: "Wanda"},
    {name: "Xin"},
    {name: "Yvonne"},
    {name: "Zoe"}
])
profile = Profile.create!(user_id: user.id, school: 'SEAS', degree: 'MS', major: 'CS')
# post
post = Post.create!(user_id: user.id, title: '4995 SAAS Project Team', content: "I would like to find teammates for Project Meerkat.", next_nickname_id: 3, low_number: 3, high_number: 4, start: '2021-09-09', end: '2021-12-12')
tag = Tag.create!(name: 'coursework', freq: 1)
PostTag.create!(post_id: post.id, tag_name: tag.name)
group = Group.create(post_id: post.id)
GroupUser.create(group_id: group.id, user_id: user.id, is_host: true, status: :accepted)
GroupUser.create(group_id: group.id, user_id: user1.id, status: :accepted)
GroupUser.create(group_id: group.id, user_id: user2.id, status: :accepted)
# comments
c1 = Comment.create!(post_id: post.id, content: "What tech stack will you use?", is_public: true, from_user_id: user1.id)
c2 = Comment.create!(post_id: post.id, content: "Ruby on Rails", is_public: true, from_user_id: user.id, to_comment_id: c1.id, to_user_id: user1.id, to_comment_leader_id: c1.id)
c3 = Comment.create!(post_id: post.id, content: "How's your background?", is_public: true, from_user_id: user2.id)
c4 = Comment.create!(post_id: post.id, content: "I have one year experience of full stack development", is_public: true, from_user_id: user.id, to_comment_id: c3.id, to_user_id: user2.id, to_comment_leader_id: c3.id)

PostUserNickname.create([
    {post_id: post.id, user_id: user1.id, nickname_id: 1},
    {post_id: post.id, user_id: user2.id, nickname_id: 2}
])

# test_approved_wq=GroupUser.create!(group_id: group.id, user_id: 1, status: :approved)

#post2=Post.create!(user_id: 1, title: 'WQ host', content: "This is create by wq")
#group2=Group.create(post_id: post2.id)
#test_group_user1=GroupUser.create!(group_id: group2.id, user_id: user1.id, status: :applied)
#test_group_user2=GroupUser.create!(group_id: group2.id, user_id: user2.id, status: :applied)