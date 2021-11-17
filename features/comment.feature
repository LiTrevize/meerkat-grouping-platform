Feature: I joined a group and want to chat with my group members

Background: User is on the post page
Given Nicknames contain [Alice,Bob]
Given "Test_user" has go to the post page
Given Post with name "Test Post" is created by "test_host"
Given I am on the post page
And I follow "Test Post"

Scenario: User comment to all
   Then I should see "Reply to all"
   And I check "is_public"
   And I fill in "comment_box" with "my comment"
   And I press "Reply"
   Then I should see "Alice"
   And I should see "my comment"