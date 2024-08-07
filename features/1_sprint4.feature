Feature: OTP for sign up

  Scenario: User Resumes application
    Given I am on the homepage
    And I click on sign up for digibank
    And I land on the Sign up page
    When I enter a valid Name
    And I enter a valid Phone Number
    And I check all checkboxes
    And I click the Get OTP button
    And I visit the OTP page
    Then I enter the OTP and press continue
    And I proceed to the next page
    Then I am on the checklist page
    And I check all the checkboxes
    Then the Next button should be clickable and red
    Then I land on the info page
    And I click the "Next" button
    Given I am not a Tax resident , I choose no
    When I fill in "Tax Resident Country" with "USA"
    And I fill in "TIN" with "123456789"
    And I click the Next button
    Given I am on the document upload page
    And I click on the camera button to take a picture of the document
    Then I click on Take picture
    And I can see the information extracted
    And I can proceed to the next step