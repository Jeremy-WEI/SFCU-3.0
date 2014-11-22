Feature: ControlPanel
  As a SFCU employee
  I want to view the application form

  Scenario: Choose CBP forms to export
    Given I'm on the main page
    When I click the CBP link and choose some forms
    Then I should see export page
