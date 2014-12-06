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
    Then I should see errors of ssn on the page

  Scenario: Submit a CBP application form with an invalid date birth
    Given I'm on the Cbpapp form page
    When I fill in the form with an invalid date birth
    Then I should see errors of invalid date birth

  Scenario: Submit a CBP application form with Upenn email
    Given I'm on the Cbpapp form page
    When I fill in the form with Upenn email
    Then I should see errors of invalid email

  Scenario: Submit a CBP application form with an invalid phone number
    Given I'm on the Cbpapp form page
    When I fill in the form with an invalid phone number
    Then I should see errors of invalid phone number

#
#  Scenario: Submit a CBP application form without account number
#    Given I'm on the Cbpapp form page
#    When I fill in the form without account number
#    Then I should see errors of account number on the page