require 'test_helper'

class UlappTest < ActiveSupport::TestCase

  test "create an ULapplication" do
    @ulapp = ulapps(:one)
    @ulapp.save
    puts @ulapp.errors.full_messages
    # assert @ulapp.save
  end

  test "should not save ULapplication with an invalid phone number" do
    @app_error1 = ulapps(:two)
    assert_not @app_error1.save, "Save the ULapplication with an invalid phone number"
    assert @app_error1.errors.full_messages.include? "Phone number Format of phone_number isn't recognized"
  end

  test "should not save ULapplication without accepting terms and condition" do
    @app_error2 = ulapps(:three)
    assert_not @app_error2.save, "Save the ULapplication without accepting terms and condition"
    assert @app_error2.errors.full_messages.include? "Terms must be accepted in order to proceed"
  end

  test "should not save a blank form" do
    @app_error3 = ulapps(:four)
    assert_not @app_error3.save
  end

  test "should not save ULapplication without invalid alternative phone number" do
    @ulapp = ulapps(:one)
    @ulapp.alter_number = "1234"
    assert_not @ulapp.save
    assert @ulapp.errors.full_messages.include? "Alter number Format of alter_number isn't recognized"
  end

  test "should not save ULapplication without graduation date" do
    @ulapp = ulapps(:one)
    @ulapp.graduation = ""
    assert_not @ulapp.save
    assert @ulapp.errors.full_messages.include? "Graduation Date can't be blank"
  end

  test "permanent address and local address is the same when clicking 'same'" do
    @ulapp = ulapps(:one)
    @ulapp.same = "1"
    assert @ulapp.save
    assert_equal @ulapp.local_address_line1, @ulapp.perm_address_line1
    assert_equal @ulapp.local_address_line2, @ulapp.perm_address_line2
    assert_equal @ulapp.local_address_city, @ulapp.perm_address_city
    assert_equal @ulapp.local_address_state, @ulapp.perm_address_state
    assert_equal @ulapp.local_address_zip, @ulapp.perm_address_zip
    assert_equal @ulapp.local_country, @ulapp.perm_country
  end

end
