Feature: I joined a group and want to chat with my group members

Background: User is on the post page
Given Nicknames contain [Alice,Bob]
Given "Test_user" has go to the post page
Given Post with name "Test Post" is created by "test_host"
Given I am on the post page
And I follow "More..."

Scenario: User comment to all and reply to self
   Then I should see "reply to all"
   And I check "is_public"
   And I fill in "comment_box" with "my comment"
   And I press "reply"
   Then I should see "Alice"
   And I should see "my comment"

   Then I follow "reply_link_l1"
   And I should see "reply to Alice"
   And I fill in "comment_box_l1" with "reply message"
   And I press "reply_btn_l1"
   Then I should see "reply message"