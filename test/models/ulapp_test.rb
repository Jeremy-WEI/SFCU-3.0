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


end
