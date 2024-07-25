Feature: Sign-Up
  Scenario: User Takes a picture of the document and OCR is able to read it
    Given I am on the Mobile Ownership document upload page
    And I click on the camera button to take a picture of the document
    Then I click on Take picture
    And I can see the information extracted
    And I can proceed to the next step

    
  Scenario: User Takes a picture of himself instead of the document
    Given I am on the Mobile Ownership document upload page
    And I click on the camera button to take a picture of the document
    Then I click on Take picture
    And I get an error
    And I am unable to proceed to the next step
    
  Scenario: User Takes a blur picture of the document
    Given I am on the Mobile Ownership document upload page
    And I click on the camera button to take a picture of the document
    Then I click on Take picture
    And I get an error
    And I am unable to proceed to the next step

  Scenario: User Takes a picture of the document and OCR is able to read it
    Given I am on the Mobile Ownership document upload page
    And I click on the camera button to take a picture of the document
    Then I click on Take picture
    And I can see the information extracted
    And I can proceed to the next step


  Scenario: User successfully signs up an
    Given I visit the homepage and click on start
    And I click on sign up for digibank
    And I land on the Sign up with Phone number page
    When I enter a valid Name
    And I enter a valid Phone Number and set a password
    And I visit the OTP page
    Then I enter the OTP and press continue
    And I proceed to the next page
    Then I continue without Singpass
    Given I check all the checkboxes
    Then the Next button should be clickable and red
    Then I land on the address page 
    And I fill in my particulars and press next

  Scenario: User enters an invalid OTP and is unable
    Given I visit the homepage and click on start
    And I click on sign up for digibank
    And I land on the Sign up with Phone number page
    When I enter a valid Name
    And I enter a valid Phone Number and set a password
    And I visit the OTP page
    Then I entered the wrong OTP and press continue
    And I am unable to proceed to the next page

  Scenario: User Takes a blur picture of the document 
    Given I am on the Mobile Ownership document upload page
    And I click on the camera button to take a picture of the document
    Then I click on Take picture 
    And I get an error

  Scenario: User Takes a Clear picture of the document and OCR is able to extract data correctly
    Given I am on the Mobile Ownership document upload page
    And I click on the camera button to take a picture of the document
    Then I click on Take picture