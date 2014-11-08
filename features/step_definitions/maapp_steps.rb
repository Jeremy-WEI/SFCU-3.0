Given(/^I'm on the Maapp form page$/) do
  visit new_maapp_path
end

When(/^I fill in the form and submit the Maapp form$/) do
  choose('maapp_student_status_0')
  fill_in('maapp_first', :with => 'John')

  click_button 'Submit'
end

Then(/^I should see the newly created Maapp form$/) do
  assert page.has_content?('Maapp was successfully created.')
end