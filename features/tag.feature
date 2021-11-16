Feature: I post posts

Background: test user already logged in and went to the post page
 Given "TestUser@columbia.edu" is logged in
 When I am on the profile page
 And I press "Continue"
 And I follow "Go to Posts"
 Then I should see "Posts"

Scenario: create new post, assign tags, and find the tag on index page
 When I follow "New Post"
 Then I should see "Complete Your Post"
 
 And I fill in "Title" with "Test Post"
 And I fill in "Content" with "Hello, this is a test post"
 And I fill in "tag1" with "1"
 And I fill in "tag2" with "2"
 And I fill in "tag3" with "3"

 And I press "Create"
 Then I should be on the post page
 And I should see "1"
 And I should see "2"
 And I should see "3"


 When I follow "New Post"
 Then I should see "Complete Your Post"
 
 And I fill in "Title" with "Test Post 2"
 And I fill in "Content" with "Hello, this is a test post 2"
 And I fill in "tag1" with ""
 And I fill in "tag2" with ""
 And I fill in "tag3" with ""

And I press "Create"
 Then I should be on the post page
 And I should see "1"
 And I should see "2"
 And I should see "3" 
 And I should see "other"