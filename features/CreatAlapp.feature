Feature: Al Application submission
  As an applicant
  I want to submit a Al application form

  Scenario: Submit a Al application form
    Given I'm on the Alapp form page
    When I fill in the form and submit the Alapp form
    Then I should see the newly created Alapp form
