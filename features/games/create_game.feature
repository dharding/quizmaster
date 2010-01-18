Feature: Create game
  In order to setup the quiz game
  As an admin
  I want to be able to create games

  
  Scenario: Anonymous user cannot create a game
    Given I am not logged in
    When I go to the new game page
    Then I should be on the login page

  Scenario: Non-admin cannot create a game
    Given the following user records
      | email           | password |
      | sam@example.com | secret   |
    And I am logged in as "sam@example.com" with password "secret"
    And I go to the new game page
    Then I should be on the home page

  Scenario: Admin can create a game
    Given the following admin records
      | email             | password |
      | admin@example.com | secret   |
    When I am logged in as "admin@example.com" with password "secret"
    And I go to the games page
    And I press "Add Game"
    Then I should be on the new game page
    When I fill in "Rounds" with "5"
    And I fill in "Questions Per Round" with "5"
    And I press "Add Game"
    Then I should see "Game created"
    And there should be 1 game
    
  Scenario: Admin can create a game with teams
    Given the following admin records
      | email             | password |
      | admin@example.com | secret   |
    And the following user records
      | email           |
      | bob@example.com |
      | sam@exmaple.com |
      | joe@example.com |
      | hal@example.com |
    And the following team records
      | name           | captain_by_email |
      | Fighting Fools | bob@example.com  |
      | Sleepy Sloths  | hal@example.com  |
      # | Empty Team     |                  |
    When I am logged in as "admin@example.com" with password "secret"
    And I go to the games page
    And I press "Add Game"
    Then I should be on the new game page
    When I fill in "Rounds" with "5"
    And I fill in "Questions Per Round" with "5"
    And I check "Fighting Fools"
    And I check "Sleepy Sloths"
    And I press "Add Game"
    Then I should see "Game created"
    And there should be 2 games teams
    