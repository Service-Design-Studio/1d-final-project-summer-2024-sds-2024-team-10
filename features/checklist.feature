Feature: Checklist Page

  Scenario: User Has prepared all his documents
    Given I am on the checklist page
    Given I check all the checkboxes
    Then the Next button should be clickable and red

  Scenario: User is Tamil and was able to understand and prepare the required documents
    Given I am on the checklist page displayed in Tamil according to my language preference 
    Given I check all the checkboxes
    Then the Next button should be clickable and red

  Scenario: User is Chinease and was able to understand and prepare the required documents
    Given I am on the checklist page displayed in Chinese according to my language preference 
    Given I check all the checkboxes
    Then the Next button should be clickable and red

