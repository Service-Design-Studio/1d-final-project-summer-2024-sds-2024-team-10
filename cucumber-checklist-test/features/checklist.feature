Feature: Document Checklist Form

  Scenario: Next button is grayed out when some checkboxes are unchecked
    Given I am on the checklist page
    And I see the following checklist items:
      | Passport                   | unchecked |
      | Employment                 | checked   |
      | Address                    | unchecked |
      | Tax                        | checked   |
      | Mobile                     | unchecked |
      
    Then the Next button should be grayed out
