Feature: I joined a group and want to chat with my group members

Background: User is on the post page
Given "Test_user" has go to the post page

Scenario: User goes to the group chat page
   Given Post with name "Test Post" is created by "test_host"
   Given I joined group for post "Test Post"
   When I am on the post page
   Then I should see "Test Post"
   And I follow "More..."
   Then I should see "Go to Chat"
   Then I follow "Go to Chat"
   And I should see "Group Chat"
   Then I fill in "chat_box" with "hello"
   And I press "Send"
   Then I should see "hello"

Scenario: User wants to go to a dismissed group chat page
   Given Post with name "Test Post" is created by "test_host"
   Given I joined group for post "Test Post"
   Given Group for post "Test Post" is dismissed
   When I am on the post page
   Then I should see "Test Post"
   And I follow "More..."
   Then I should see "Go to Chat"
   Then I follow "Go to Chat"
   And I should see "This group is dismissed. You can only view history chats."
   
Scenario: User wants to access the group chat without joining
   Given Post with name "Test Post" is created by "test_host"
   Given Group for post "Test Post" is dismissed
   When I am on the post page
   Then I should see "Test Post"
   And I follow "More..."
   Then I should see "Go to Chat"
   Then I follow "Go to Chat"
   And I should see "You have not joined the group, only group members can access the group chat"