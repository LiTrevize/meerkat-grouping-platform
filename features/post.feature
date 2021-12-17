Feature: I post posts

Background: test user already logged in and went to the post page
 Given "TestUser@columbia.edu" is logged in
 When I am on the create profile page
 And I press "Continue"
 And I follow "Go to Posts"
 Then I should see "New Post"

Scenario: create new post, edit post, and delete post
 When I follow "New Post"
 Then I should see "Complete Your Post"
 
 And I fill in "Title" with "Test Post"
 And I fill in "Content" with "Hello, this is a test post"
 And I fill in "Start Date" with "01/01/2022"
 And I fill in "End Date" with "01/02/2022"
 And I fill in "low" with "1"
 And I fill in "high" with "3"
 And I fill in "tag1" with "t1"
 And I press "Create"
 Then I should be on the post page
 And I should see "Test Post"
 
 When I follow "Edit"
 Then I should see "Edit Your Post"
 And I fill in "Title" with "Edit Post"
 And I fill in "Content" with "I edit the post"
 And I press "Save Changes"
 Then I should be on the post page
 And I should see "Edit Post"
 And I should not see "Test Post"
 
 When I follow "Delete"
 Then I should not see "Edit Post"

 Scenario: create new post, edit post, and delete post
 When I follow "New Post"
 Then I should see "Complete Your Post"
 
 And I fill in "Title" with "Test Post"
 And I fill in "Content" with "Hello, this is a test post"
 And I fill in "Start Date" with "01/01/2022"
 And I fill in "End Date" with "01/02/2021"
 And I fill in "low" with "5"
 And I fill in "high" with "3"
 And I fill in "tag1" with "t1"
 And I press "Create"
 Then I should be on the create post page
 And I should see "At least people cannot be greater than At most people"
 And I should see "Start date cannot be later than End date"
 And I should see "End date cannot be prior to today"
 
Scenario: Edit Profile
  When I follow "Me"
  Then I should be on the profile page
  
  And I fill in "School" with "SEAS"
  And I fill in "Degree" with "Bachelor"
  And I fill in "Major" with "Computer Science"
  And I press "Save"


Scenario: filter all posts by tags
 When I follow "New Post"
 Then I should see "Complete Your Post"
 
 And I fill in "Title" with "Test Post"
 And I fill in "Content" with "Hello, this is a test post"
 And I fill in "Start Date" with "01/01/2022"
 And I fill in "End Date" with "01/02/2022"
 And I fill in "low" with "1"
 And I fill in "high" with "3"
 And I fill in "tag1" with "t1"
 And I press "Create"
 Then I should be on the post page
 And I should see "Test Post"

 When I follow "New Post" 
 And I fill in "Title" with "T_Post"
 And I fill in "Content" with "aaaa"
 And I fill in "Start Date" with "01/01/2022"
 And I fill in "End Date" with "01/02/2022"
 And I fill in "low" with "1"
 And I fill in "high" with "3"
 And I fill in "tag1" with "t2"
 And I press "Create"
 Then I should be on the post page
 And I check "tagnames_t1"
 And I press "filter"
 And I should not see "T_Post"
