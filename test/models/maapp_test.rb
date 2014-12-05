require 'test_helper'

class MaappTest < ActiveSupport::TestCase


  test "create an MAapplication" do
    @maapp = maapps(:one)
    @maapp.save
    puts @maapp.errors.full_messages
    assert @maapp.save
  end

  test "should not save MAapplication without ssn and w8ben form" do
    @app_error1 = maapps(:two)
    assert_not @app_error1.save, "Save the application without ssn and w8ben form"
    assert @app_error1.errors.full_messages.include? "W8ben form can't be blank"
  end

  test "should not save MAapplication without penn email when user is penn student" do
    @app_error2 = maapps(:three)
    assert_not @app_error2.save, "Save the application without penn email when user is penn student"
    assert @app_error2.errors.full_messages.include? "Penn email is invalid"
  end

  # test "should not save an invalid MAapplication" do
  #   @app_error3 =
  # end

end
