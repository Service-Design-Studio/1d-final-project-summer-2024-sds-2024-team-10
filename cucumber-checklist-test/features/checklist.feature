Feature: Document Checklist Form
  Scenario: Next button becomes clickable when all checkboxes are checked
    Given I am on the checklist page
    And I see the following checklist items:
      | Document                    | Status   |
      | Passport                    | checked  |
      | Proof of Employment         | checked  |
      | Proof of Residential Address| checked  |
      | Proof of Tax Residency      | checked  |
      | Proof of Mobile Ownership   | checked  |
    Then the Next button should be clickable and red

  Scenario: Next button is grayed out when some checkboxes are unchecked
    Given I am on the checklist page
    And I see the following checklist items:
      | Document                    | Status   |
      | Passport                    | checked  |
      | Proof of Employment         | unchecked|
      | Proof of Residential Address| unchecked|
      | Proof of Tax Residency      | unchecked|
      | Proof of Mobile Ownership   | unchecked|
    Then the Next button should be grayed out

  Scenario: Next button is grayed out when some checkboxes are unchecked
    Given I am on the checklist page
    And I see the following checklist items:
      | Document                    | Status   |
      | Passport                    | checked  |
      | Proof of Employment         | checked  |
      | Proof of Residential Address| unchecked|
      | Proof of Tax Residency      | unchecked|
      | Proof of Mobile Ownership   | unchecked|
    Then the Next button should be grayed out

  Scenario: Next button is grayed out when some checkboxes are unchecked
    Given I am on the checklist page
    And I see the following checklist items:
      | Document                    | Status   |
      | Passport                    | checked  |
      | Proof of Employment         | unchecked|
      | Proof of Residential Address| unchecked|
      | Proof of Tax Residency      | checked  |
      | Proof of Mobile Ownership   | unchecked|
    Then the Next button should be grayed out