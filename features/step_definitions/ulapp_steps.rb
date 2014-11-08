Given(/^I'm on the Ulapp form page$/) do
  visit new_ulapp_path
end

When(/^I fill in the form and submit the Ulapp form$/) do
  choose('ulapp_credit_type_0')
  fill_in('ulapp_amount', :with => '50000')

  click_button 'Submit'
end

Then(/^I should see the newly created Ulapp form$/) do
  assert page.has_content?('Ulapp was successfully created.')
end