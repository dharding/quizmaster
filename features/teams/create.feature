Feature: Create team
  In order to setup the quiz game
  As an admin
  I want to be able to create teams
  
  Scenario: Anonymous user cannot create a team
    Given I am not logged in
    When I go to the new team page
    Then I should be on the login page
  
  Scenario: Non-admin cannot create a team
    Given the following user records
      | email           | password |
      | sam@example.com | secret   |
    And I am logged in as "sam@example.com" with password "secret"
    And I go to the new team page
    Then I should be on the home page
  
  Scenario: Admin can create a team without a captain
    Given the following admin records
      | email             | password |
      | admin@example.com | secret   |
    When I am logged in as "admin@example.com" with password "secret"
    And I go to the teams page
    And I press "Add Team"
    Then I should be on the new team page
    When I fill in "Name" with "Fighting Fools"
    And I press "Add Team"
    Then I should see "Team 'Fighting Fools' has been created."
  
  Scenario: Admin can create a team with a captain
    Given the following user records
      | first_name | last_name |
      | David      | Davies    |
      | Sally      | Fields    |
    And the following admin records
      | email             | password |
      | admin@example.com | secret   |
    When I am logged in as "admin@example.com" with password "secret"
    And I go to the teams page
    And I press "Add Team"
    Then I should be on the new team page
    When I fill in "Name" with "Fighting Fools"
    And I select "David Davies" from "Captain"
    And I press "Add Team"
    Then I should see "Team 'Fighting Fools' has been created."
    And I should see "David Davies"
    
  # Scenario: Admin can create a team with a captain and members
  #   Given the following user records
  #     | first_name | last_name |
  #     | David      | Davies    |
  #     | Sally      | Fields    |
  #     | Alex       | Chilton   |
  #   And the following admin records
  #     | email             | password |
  #     | admin@example.com | secret   |
  #   When I am logged in as "admin@example.com" with password "secret"
  #   And I go to the teams page
  #   And I press "Add Team"
  #   Then I should be on the new team page
  #   When I fill in "Name" with "Fighting Fools"
  #   And I select "David Davies" from "Captain"
  #   And I press "Add a Member"
  #   And I select "Alex Chilton" from "New Member"
  #   And I press "Add Team"
  #   Then I should see "Team 'Fighting Fools' has been created."
  #   And I should see "David Davies"
  #   And I should see "Alex Chilton"
