Feature: Ma Application submission
  As an applicant
  I want to submit a Ma application form

  Scenario: Submit a Ma application form
    Given I'm on the Maapp form page
    When I fill in the form and submit the Maapp form
    Then I should see the newly created Maapp form
