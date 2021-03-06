Given(/^I'm on the Cbpapp form page$/) do
  visit new_cbpapp_path
end

When(/^I fill in the form and submit the form$/) do
  fill_in('cbpapp_first_name', :with => 'Mike')
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '123456789')
  fill_in('cbpapp_dob', :with => '09/07/1956')
  # select '1956', from: 'cbpapp_dob_1i'
  # select 'July', from: 'cbpapp_dob_2i'
  # select '9', from: 'cbpapp_dob_3i'
  fill_in('cbpapp_account_number', :with => '1234')
  fill_in('cbpapp_mother_maiden', :with => 'Peterson')
  fill_in('cbpapp_grad_date', :with => '01/07/2015')
  # select '2015', from: 'cbpapp_grad_date_1i'
  # select 'June', from: 'cbpapp_grad_date_2i'
  # select '1', from: 'cbpapp_grad_date_3i'
  fill_in('cbpapp_non_upenn_email', :with => 'mikefarmer@gmail.com')
  fill_in('cbpapp_how_know', :with => 'Chris')
  fill_in('cbpapp_local_home_phone', :with => '2152345093')
  fill_in('cbpapp_local_address_line1', :with => 'Room 1102, 3800 Chestnut St.')
  fill_in('cbpapp_local_address_city', :with => 'Philadelphia')
  fill_in('cbpapp_local_address_state', :with => 'Pennsylvania')
  choose('cbpapp_period_12_months')
  choose('cbpapp_student_status_us_citizen_or_permanent_resident')

  click_button 'Submit'
end

Then(/^I should see the newly created Cbpapp form$/) do
  assert page.has_content?('Thank you for banking with the SFCU, the first and only student-run Credit Union in the Ivy league!')
end

When(/^I fill in the form with an invalid SSN$/) do
  fill_in('cbpapp_first_name', :with => 'Mike')
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '12345')
  fill_in('cbpapp_account_number', :with => '1234')

  click_button 'Submit'
end

Then(/^I should see errors of ssn on the page$/) do
  # assert page.has_css?('div.field_with_errors')
  assert page.has_content?('SSN is invalid')
end

When(/^I fill in the form with an invalid date birth$/) do
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '123456789')
  fill_in('cbpapp_account_number', :with => '1234')
  fill_in('cbpapp_dob', :with => '09/07/2015')
  # select '2015', from: 'cbpapp_dob_1i'
  # select 'July', from: 'cbpapp_dob_2i'
  # select '9', from: 'cbpapp_dob_3i'
  click_button 'Submit'
end

Then(/^I should see errors of invalid date birth$/) do
  # assert page.has_css?('div.field_with_errors')
  assert page.has_content?("must be in the past")
end

When(/^I fill in the form with Upenn email$/) do
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '123456789')
  fill_in('cbpapp_account_number', :with => '1234')
  fill_in('cbpapp_non_upenn_email', :with => 'mikefarmer@seas.upenn.edu')

  click_button 'Submit'
end

Then(/^I should see errors of invalid email$/) do
  # assert page.has_css?('div.field_with_errors')
  assert page.has_content?("Alternate Email is invalid")
end

When(/^I fill in the form with an invalid phone number$/) do
  fill_in('cbpapp_last_name', :with => 'Farmer')
  fill_in('cbpapp_ssn', :with => '123456789')
  fill_in('cbpapp_account_number', :with => '1234')
  fill_in('cbpapp_local_home_phone', :with => '+12152340956')
  click_button 'Submit'
end

Then(/^I should see errors of invalid phone number$/) do
  # assert page.has_css?('div.field_with_errors')
  assert page.has_content?("Home Phone is invalid")
end

# Then(/^I should see errors of first name on the page$/) do
#   assert page.has_css?('div.field_with_errors')
#   assert page.has_content?("First name can't be blank")
# end

#
# When(/^I fill in the form without account number$/) do
#   choose('cbpapp_period_0')
#   fill_in('cbpapp_first_name', :with => 'Mike')
#   fill_in('cbpapp_last_name', :with => 'Farmer')
#   fill_in('cbpapp_ssn', :with => '123456789')
#
#   click_button 'Submit'
# end
#
# Then(/^I should see errors of first name on the page$/) do
#   assert page.has_css?('div.field_with_errors')
#   assert page.has_content?("First name can't be blank")
# end
#
# Then(/^I should see errors of account number on the page$/) do
#   assert page.has_css?('div.field_with_errors')
#   assert page.has_content?("Account number can't be blank")
# end

