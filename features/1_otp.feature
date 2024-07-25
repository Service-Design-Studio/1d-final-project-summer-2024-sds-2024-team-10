Feature: OTP for sign up

  Scenario: User successfully signs up an
    Given I visit the homepage and click on start
    And I click on sign up for digibank
    And I land on the Sign up with Phone number page
    When I enter a valid Name
    And I enter a valid Phone Number and set a password
    And I visit the OTP page
    Then I enter the OTP and press continue


  Scenario: User enters an invalid OTP and is unable to proceed to the next step
    Given I visit the homepage and click on start
    And I click on sign up for digibank
    And I land on the Sign up with Phone number page
    When I enter a valid Name
    And I enter a valid Phone Number and set a password
    And I visit the OTP page
    Then I entered the wrong OTP and press continue
    And I am unable to proceed to the next page