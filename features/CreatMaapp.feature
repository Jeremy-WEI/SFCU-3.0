Feature: Ma Application submission
  As an applicant
  I want to submit a Ma application form

  Scenario: Submit a Ma application form with an invalid SSN
    Given I'm on the Maapp form page
    When I fill in the form with an invalid SSN
    Then I should see errors of ssn on the page
