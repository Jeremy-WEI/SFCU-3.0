require 'test_helper'

class CbpappTest < ActiveSupport::TestCase

  test "create an CBPapplication" do
    @cbpapp = cbpapps(:one)
    assert @cbpapp.save
  end

  test "should not save an CBPapplication with invalid ssn" do
    @cbpapp_error1 = cbpapps(:two)
    assert_not @cbpapp_error1.save
    assert @cbpapp_error1.errors.full_messages.include? "SSN is invalid"
  end

end
