Feature: I visit my profile page

Background: test user already logged in and went to the post page
 Given "TestUser@columbia.edu" is logged in
 When I am on the create profile page
 And I press "Continue"
 And I follow "Go to Posts"

Scenario: User apply for a group and should see that group in "My Applications"
   Given Post with name "Test Post" is created by "test_host"
   Given I applied for post "Test Post"
   And I follow "Me"
   And I should see "My Applications"
   And I should see "Test Post"

Scenario: User can see all the groups that he joined in "My Groups"
   Given Post with name "Test Post_2" is created by "test_host_2"
   Given I joined group for post "Test Post_2"
   And I follow "Me"
   And I should see "My Groups"
   And I should see "Test Post_2"


Scenario: User can approve or reject applictions in "Applications to review"
 When I follow "New Post"
 
 And I fill in "Title" with "Test Post 3"
 And I fill in "Content" with "this is a test post 3"
 And I fill in "Start Date" with "01/01/2022"
 And I fill in "End Date" with "01/02/2022"
 And I fill in "low" with "1"
 And I fill in "high" with "3"
 And I press "Create"
 Then I should be on the post page
 And I should see "Test Post 3"
 
 Given "Bob" applied for post "Test Post 3" with messsage "Hi"
 
 And I follow "Me"
 And I should see "Applications to review"
 And I should see "Test Post 3"
 And I should see "Hi"
 
 And I should see "Approve"
 And I follow "Approve"
 
 Given "Bob" accepted the invitation for "Test Post 3"
 And I follow "Back to Posts"
 And I follow "More..."
 Then I should see "Test Post 3"
 
 Then I follow "Go to Chat"
 And I should see "Bob"
 
 And I follow "Bob"
 And I should see "Profile"

 

   
   

