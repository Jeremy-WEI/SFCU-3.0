Given(/^I'm on the Alapp form page$/) do
  visit new_alapp_path
end

When(/^I fill in the form and submit the Alapp form$/) do
  choose('alapp_alumni_true')
  fill_in('alapp_first', :with => 'John')

  click_button 'Save'
end

Then(/^I should see the newly created Alapp form$/) do
  assert page.has_content?('Alapp was successfully created.')
end