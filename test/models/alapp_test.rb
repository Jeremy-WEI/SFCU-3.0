require 'test_helper'

class AlappTest < ActiveSupport::TestCase
  test "create an ALapplication" do
    @alapp = alapps(:one)
    @alapp.save
    puts @alapp.errors.full_messages
  end

  test "should not save an invalid ALapplication" do
    @alapp_error = alapps(:two)
    assert_not @alapp_error.save
  end
end
