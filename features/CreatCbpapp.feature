Feature: Cbp Application submission
  As an applicant
  I want to submit a CBP application form

  Scenario: Submit a CBP application form
    Given I'm on the Cbpapp form page
    When I fill in the form and submit the form
    Then I should see the newly created Cbpapp form

  Scenario: Submit a CBP application form with an invalid SSN
    Given I'm on the Cbpapp form page
    When I fill in the form with an invalid SSN
    Then I should see errors on the page

