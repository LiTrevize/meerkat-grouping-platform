Feature: I post posts

Background: test user already logged in and went to the post page
 Given "TestUser@columbia.edu" is logged in
 When I am on the profile page
 And I press "Continue"
 And I follow "Go to Posts"
 Then I should see "Posts"

Scenario: create new post, edit post, and delete post
 When I follow "New Post"
 Then I should see "Complete Your Post"
 
 And I fill in "Title" with "Test Post"
 And I fill in "Content" with "Hello, this is a test post"
 And I press "Create"
 Then I should be on the post page
 And I should see "Test Post"

 When I follow "Edit"
 Then I should see "Edit Your Post"
 And I fill in "Title" with "Edit Post"
 And I fill in "Content" with "I edit the post"
 And I press "Save"
 Then I should be on the post page
 And I should see "Edit Post"
 And I should not see "Test Post"
 
 When I follow "Delete"
 Then I should not see "Edit Post"
 
Scenario: Edit Profile in Post page
  When I follow "My Profile"
  Then I should be on the old profile page
  
  And I fill in "School" with "SEAS"
  And I fill in "Degree" with "Bachelor"
  And I fill in "Major" with "Computer Science"
  And I press "Save"
