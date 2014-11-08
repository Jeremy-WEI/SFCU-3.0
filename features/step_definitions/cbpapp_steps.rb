Given(/^I'm on the Cbpapp form page$/) do
  visit new_cbpapp_path
end

When(/^I fill in the form and submit the form$/) do
  choose('cbpapp_period_0')
  fill_in('cbpapp_first_name', :with => 'Mike')
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '123456789')
  fill_in('cbpapp_account_number', :with => '1234')

  click_button 'Submit'
end

Then(/^I should see the newly created Cbpapp form$/) do
  assert page.has_content?('Cbpapp was successfully created.')
end

When(/^I fill in the form with an invalid SSN$/) do
  choose('cbpapp_period_0')
  fill_in('cbpapp_first_name', :with => 'Mike')
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '12345')
  fill_in('cbpapp_account_number', :with => '1234')

  click_button 'Submit'
end

Then(/^I should see errors of ssn on the page$/) do
  assert page.has_css?('div.field_with_errors')
  assert page.has_content?('Ssn is not a valid SSN')
end

When(/^I fill in the form without first name$/) do
  choose('cbpapp_period_0')
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '123456789')
  fill_in('cbpapp_account_number', :with => '1234')

  click_button 'Submit'
end

When(/^I fill in the form without account number$/) do
  choose('cbpapp_period_0')
  fill_in('cbpapp_first_name', :with => 'Mike')
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '123456789')

  click_button 'Submit'
end

Then(/^I should see errors of first name on the page$/) do
  assert page.has_css?('div.field_with_errors')
  assert page.has_content?("First name can't be blank")
end

Then(/^I should see errors of account number on the page$/) do
  assert page.has_css?('div.field_with_errors')
  assert page.has_content?("Account number can't be blank")
end

