Feature: Language selection

  Scenario: User is fluent in reading chinese and chooses "中文" from the language dropdown
    Given I visit the homepage and click on start
    When I click on the language dropdown
    When I select "中文" from the language dropdown
    Then I should see the page content in Chinese
    When I click on 注册Digibank
    Then I land on the page to sign up for Singpass
    And I continue without Singpass
    Given I am on the checklist page displayed in Chinese according to my language preference 
    Given I check all the checkboxes
    Then the Next button should be clickable and red


  Scenario:User is fluent in reading Tamil and chooses "தமிழ்" from the language dropdown

    Given I visit the homepage and click on start
    When I click on the language dropdown
    When I select "தமிழ்" from the language dropdown
    Then I should see the page content in Tamil
    When I click on டிஜிபாங்க் பதிவு செய்யவும்
    Then I arrive on the page to sign up for Singpass
    And I continue without Singpass
    Given I am on the checklist page displayed in Tamil according to my language preference 
    Given I check all the checkboxes
    Then the Next button should be clickable and red

  Scenario: User is comfortable with English so continues using the default language of the app
    Given I visit the homepage and click on start
    When I click on the language dropdown
    Then I click on sign up for digibank
    Then I land on the sign up page for Singpass
    And I continue without Singpass
    Given I am on the checklist page
    Given I check all the checkboxes
    Then the Next button should be clickable and red

  Scenario: User can only read in Malay and cannot read the available languages
    Given I visit the homepage and click on start
    When I click on the language dropdown
    Then I realize malay is not an option
    Then the User is stuck in the application process


