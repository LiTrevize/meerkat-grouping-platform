Feature: I would like to sign up with Google and log out
 
Scenario: visit the Meerkat home page for the first time
  When I am on the home page
  Then I should see "Meerkat"
  And I should see "Log in with Google"  

Scenario: fill out Profile, go to the home page, and log out
  Given "TestUser@columbia.edu" is logged in
  
  When I am on the profile page
  Then I should see "Degree"

  And I fill in "School" with "SEAS"
  And I fill in "Degree" with "Bachelor"
  And I fill in "Major" with "Computer Science"
  And I press "Continue"
  
  Then I should be on the home page
  And I should see "Hello, Test User"
  And I should see "Log out"
  And I should see "Go to Posts"
  
  Then I follow "Log out"
  And I should see "Meerkat"
  And I should see "Log in with Google"   
