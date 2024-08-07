
Feature: Language selection

  Scenario: User selects each language from the dropdown
    Given I am on the homepage
    When I select "தமிழ்" from the language dropdown
    And I click next
    Given I am on the homepage
    When I select "简体中文" from the language dropdown
    And I click next
    Given I am on the homepage
    When I select "Bahasa Melayu" from the language dropdown
    And I click next
    Given I am on the homepage
    When I select "English" from the language dropdown
    And I click next
    Then I enter a valid Name,Phone Number and set a password
    And I click the button to get OTP
    And I visit the OTP page
    Then I enter the OTP and press continue
    And I proceed to the next page
    And I sign up without Singpass
    And I land on the Checklist page to verify my Documents
    And I check all the checkboxes
    And 




