Feature: Edit question
  In order to setup the quiz game
  As an admin
  I want to be able to edit questions
  
  Background:
    Given the following question records
      | ask                          |
      | What is your favorite color? |
  
  Scenario: Anonymous user cannot edit a question
    Given I am not logged in
    When I try to edit the question with the "ask" "What is your favorite color?"
    Then I should be on the login page

  Scenario: Non-admin cannot edit a question
    Given the following user records
      | email           | password |
      | sam@example.com | secret   |
    And I am logged in as "sam@example.com" with password "secret"
    When I try to edit the question with the "ask" "What is your favorite color?"
    Then I should be on the home page

  Scenario: Admin can edit a question
    Given the following admin records
      | email             | password |
      | admin@example.com | secret   |
    When I am logged in as "admin@example.com" with password "secret"
    And I go to the questions page
    And I press "Edit"
    When I fill in "Ask" with "What is your favorite food?"
    And I fill in "Answer" with "Cassoulet"
    And I select "Easy" from "Difficulty"
    And I press "Update Question"
    Then I should see "Question updated"
    And I should not see "What is your favorite color?"
    And I should see "What is your favorite food?"
    And there should be 1 question