Feature: I apply for a group and my status should change

Background: User is on the post page
Given "Test_User_2" has go to the post page

Scenario: User applies for a group and the status should change to applied
   Given Post with name "Apply Test Post" is created by "apply_test_host"
   When I am on the post page
   Then I should see "Apply Test Post"
   And  I follow "More..."
   Then I should see "Apply Test Post content"
   And I should see "You haven't applied for this Group"
   And I should see "Apply" 
   Then I press "Apply"
   And I should see "status: applied"

Scenario: User's group application is approved by the host, the status shoud change to accepted, and user should be able to accept the group invitation
   Given Post with name "Approve Test Post 1" is created by "approve_test_host" and my application is approved
   When I am on the post page
   And  I follow "More..."
   And I should see "status: approved"
   And I should see "Accept the invitation!"
   And I should see "Hmmm..I don't want to join anymore"
   
   Then I follow "Accept the invitation!"
   And I should see "You are a group member!"
   
Scenario: User's group application is approved by the host, the status shoud change to accepted, and user should be able to refuse the group invitation
   Given Post with name "Approve Test Post 2" is created by "approve_test_host" and my application is approved
   When I am on the post page
   And  I follow "More..."
   And I should see "status: approved"
   And I should see "Accept the invitation!"
   And I should see "Hmmm..I don't want to join anymore"
   
   Then I follow "Hmmm..I don't want to join anymore"
   And I should see "You have applied for this group before and you were invited to join, but you refused the invitation."

Scenario: User has created a post and someone applied for it, user should be able to approve the application
   Given I created a post with name "My Post 1", and "First_applied_user" applied for it
   When I am on the post page
   And I follow "More..."
   Then I should see "Pending Applications"
   And I should see "First_applied_user"   
   Then I follow "Approve"
   Then I should see "First_applied_user"
   
Scenario: User has created a post and someone applied for it, user should be able to reject the application
   Given I created a post with name "My Post 2", and "Second_applied_user" applied for it
   When I am on the post page
   And I follow "More..."
   Then I should see "Pending Applications"
   And I should see "Second_applied_user"   
   Then I follow "Reject"
   Then I should not see "Second_applied_user" 
   