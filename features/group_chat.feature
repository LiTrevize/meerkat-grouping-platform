Feature: I joined a group and want to chat with my group members

Background: User is on the post page
Given "Test_user" has go to the post page

Scenario: User goes to the group chat page
   Given Post with name "Test Post" is created by "test_host"
   Given I joined group for post "Test Post"
   When I am on the post page
   Then I should see "Test Post"
   And I follow "Test Post"
   Then I should see "Go to Group Chat"
   Then I follow "Go to Group Chat"
   And I should see "Group Chat"
   Then I fill in "chat_box" with "hello"
   And I press "Send"
   Then I should see "hello"
