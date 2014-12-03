require 'test_helper'

class AlappTest < ActiveSupport::TestCase
  test "create an ALapplication" do
    @alapp = alapps(:one)
    @alapp.save
    puts @alapp.errors.full_messages
  end
end
