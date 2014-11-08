Given(/^I'm on the Cbpapp form page$/) do
  visit new_cbpapp_path
end

When(/^I fill in the form and submit the form$/) do
  choose(' International ')
  find(:text => 'Period*').choose(' 12 Months ')
  fill_in('ssn', :with => '123456789')
  click_button 'Submit'
end

Then(/^I should see the newly created Cbpapp form$/) do
  assert page.has_content?('Cbpapp was successfully created.')
end

When(/^I fill in the form with an invalid SSN$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see errors on the page$/) do
  pending # express the regexp above with the code you wish you had
end

