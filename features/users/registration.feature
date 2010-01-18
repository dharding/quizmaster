Feature: New user registration
  In order to play the quiz game
  As a site visitor
  I want to be able to register
  
  Scenario: Visitor clicks on the sign up link
    Given I am not logged in
    When I go to the homepage
    When I follow "Register"
    Then I should see "Registration"
  
  Scenario: Visitor registers with valid information
    Given I am not logged in
    When I go to the homepage
    And I follow "Register"
    Then I fill in "First Name" with "Alex"
    And I fill in "Last Name" with "Chilton"
    And I fill in "Email" with "alex@cookco.com"
    And I fill in "Email Confirmation" with "alex@cookco.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I press "REGISTER"
    Then I should see "Your account has been created. Please check your e-mail for activation instructions."

  Scenario: Newly registered, inactive account cannot log in
    Given the following inactive user records
      | email           | password |
      | bob@example.com | secret   |
    When I go to the login page
    And I fill in "Email" with "bob@example.com"
    And I fill in "Password" with "secret"
    And I press "SIGN IN"
    Then "bob@example.com" should not be logged in