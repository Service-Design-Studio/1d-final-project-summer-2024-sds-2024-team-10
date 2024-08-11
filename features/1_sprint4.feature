Feature: OTP for sign up

  Scenario: User Resumes application
    Given I am on the homepage
    And I click on sign up for digibank
    And I land on the Sign up page
    When I enter the name Victor
    And I enter a valid Phone Number
    And I check all checkboxes
    And I click the Get OTP button
    Then I enter the OTP and press continue
    And I proceed to the next page
    Then I am on the checklist page
    And I check all the checkboxes
    Then the Next button should be clickable and red
    Then I land on the info page
    And I fill in my information
    When I select "Student" from the work dropdown
    And I select "Others" from the industry dropdown
    And I click the Next button
    Given I am not a Tax resident , I choose no
    When I fill in "Tax Resident Country" with "USA"
    And I fill in "TIN" with "349095789"
    Given I am on the document upload page
    Then I click on Take picture
