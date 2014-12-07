require 'test_helper'

class MaappTest < ActiveSupport::TestCase


  test "create an MAapplication" do
    @maapp = maapps(:Jeremy)
    assert @maapp.save
  end

  # test "should not save MAapplication without ssn and w8ben form" do
  #   @app_error1 = maapps(:two)
  #   assert_not @app_error1.save, "Save the application without ssn and w8ben form"
  #   assert @app_error1.errors.full_messages.include? "W8ben form can't be blank"
  # end

  test "should not save MAapplication without penn email when user is penn student" do
    @app_error2 = maapps(:three)
    assert_not @app_error2.save, "Save the application without penn email when user is penn student"
    assert @app_error2.errors.full_messages.include? "Penn email is invalid"
  end

  test "should not save an empty MAapplication" do
    @app_error3 = Maapp.new
    assert_not @app_error3.save
  end

  test "permanent address and local address is the same when clicking 'same'" do
    @maapp = maapps(:Jeremy)
    @maapp.same_perm_address = "1"
    assert @maapp.save
    assert_equal @maapp.local_address_line1, @maapp.perm_address_line1
    assert_equal @maapp.local_address_line2, @maapp.perm_address_line2
    assert_equal @maapp.local_address_city, @maapp.perm_address_city
    assert_equal @maapp.local_address_state, @maapp.perm_address_state
    assert_equal @maapp.local_address_zip, @maapp.perm_address_zip
  end

  test "penn affiliation should be filled by applicant when clicking 'others'" do
    @maapp = maapps(:Jeremy)
    @maapp.penn_affiliation = 'others'
    @maapp.other_penn_affiliation = 'Faculty'
    assert @maapp.save
    assert @maapp.penn_affiliation, 'Faculty'
  end

  test "should not save an invalid permanent address" do
    @maapp = maapps(:three)
    assert_not @maapp.save
  end

end
