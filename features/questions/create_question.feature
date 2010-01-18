Feature: Create question
  In order to setup the quiz game
  As an admin
  I want to be able to create questions

  
  Scenario: Anonymous user cannot create a question
    Given I am not logged in
    When I go to the new question page
    Then I should be on the login page

  Scenario: Non-admin cannot create a question
    Given the following user records
      | email           | password |
      | sam@example.com | secret   |
    And I am logged in as "sam@example.com" with password "secret"
    And I go to the new question page
    Then I should be on the home page

  Scenario: Admin can create a question
    Given the following admin records
      | email             | password |
      | admin@example.com | secret   |
    When I am logged in as "admin@example.com" with password "secret"
    And I go to the questions page
    And I press "Add Question"
    Then I should be on the new question page
    When I fill in "Ask" with "What is your favorite color?"
    And I fill in "Answer" with "Blue"
    And I select "Easy" from "Difficulty"
    And I press "Add Question"
    Then I should see "Question created"
    And there should be 1 question