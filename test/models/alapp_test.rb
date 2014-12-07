require 'test_helper'

class AlappTest < ActiveSupport::TestCase
  test "create an ALapplication" do
    @alapp = alapps(:one)
    assert @alapp.save
    puts @alapp.errors.full_messages
  end

  test "should not save an invalid ALapplication" do
    @alapp_error = alapps(:two)
    assert_not @alapp_error.save
  end

  test "should not save when first name is blank" do
    @alapp = alapps(:one)
    @alapp.first = ""
    assert_not @alapp.save
  end

  test "should not save when last name is blank" do
    @alapp = alapps(:one)
    @alapp.last = ""
    assert_not @alapp.save
  end
  test "should not save when dob is blank" do
    @alapp = alapps(:one)
    @alapp.dob = ""
    assert_not @alapp.save
  end
  test "should not save when ssn is invalid" do
    @alapp = alapps(:one)
    @alapp.ssn = "abc"
    assert_not @alapp.save
  end
  test "should not save when mother's maiden name is blank" do
    @alapp = alapps(:one)
    @alapp.mother_maiden = ""
    assert_not @alapp.save
  end
  test "should not save when alumni is blank" do
    @alapp = alapps(:one)
    @alapp.alumni = ""
    assert_not @alapp.save
  end
  test "should save false when user select false" do
    @alapp = alapps(:one)
    assert @alapp.save
    assert_equal @alapp.alumni, false
  end
  test "should not save when credit type is blank" do
    @alapp = alapps(:one)
    @alapp.credit_req_type = ""
    assert_not @alapp.save
  end
  test "should not save when amount requested is blank" do
    @alapp = alapps(:one)
    @alapp.amount_req = ""
    assert_not @alapp.save
  end
  test "should not save when term is blank" do
    @alapp = alapps(:one)
    @alapp.first = ""
    assert_not @alapp.save
  end
  test "should not save when vehicle condition is blank" do
    @alapp = alapps(:one)
    @alapp.vehicle_condition = ""
    assert_not @alapp.save
  end
  test "should not save when price_range_min is invalid" do
    @alapp = alapps(:one)
    @alapp.price_range_min = "abc"
    assert_not @alapp.save
  end
  test "should not save when price_range_max is too small" do
    @alapp = alapps(:one)
    @alapp.price_range_min = "2"
    @alapp.price_range_max = "1"
    assert_not @alapp.save
  end
  test "should not save when the form is blank" do
    @alapp = Alapp.new
    assert_not @alapp.save
  end

  test "should not save when local address is blank" do
    @alapp = alapps(:one)
    @alapp.local_address_line1 = ""
    assert_not @alapp.save
  end
  test "should not save when local address is invalid" do
    @alapp = alapps(:one)
    @alapp.local_address_line1 = "aaa"
    assert_not @alapp.save
  end
  test "should not save when local address is invalid #2" do
    @alapp = alapps(:one)
    @alapp.local_address_city = ""
    @alapp.local_address_state = ""
    @alapp.local_address_zip = ""
    assert_not @alapp.save
  end
  test "should have the same fields when perm address is the same as local address" do
    @alapp = alapps(:one)
    @alapp.perm_address_line1 = "aaa"
    @alapp.same = "1"
    assert @alapp.save
    assert @alapp.perm_address_line1 == @alapp.local_address_line1
  end

  test "should not assert address it when country is not US" do
    @alapp = alapps(:one)
    @alapp.perm_country = "CN"
    @alapp.perm_address_line1 = "aaa"
    assert @alapp.save
  end
  test "should not assert address it when country is not US #2" do
    @alapp = alapps(:one)
    @alapp.local_country = "AF"
    @alapp.local_address_line1 = "aaa"
    assert @alapp.save
  end
  test "should not save when e_mail is blank" do
    @alapp = alapps(:one)
    @alapp.e_mail = ""
    assert_not @alapp.save
  end
  test "should not save when e_mail is invalid" do
    @alapp = alapps(:one)
    @alapp.e_mail = "aaa"
    assert_not @alapp.save
  end
  test "should not save when phone_number is blank" do
    @alapp = alapps(:one)
    @alapp.phone_number = ""
    assert_not @alapp.save
  end
  test "should not save when phone_number is invalid" do
    @alapp = alapps(:one)
    @alapp.phone_number = "aaa"
    assert_not @alapp.save
  end
  test "should not save when name_nearest_relative is blank" do
    @alapp = alapps(:one)
    @alapp.name_nearest_relative = ""
    assert_not @alapp.save
  end
  test "should not save when phone_nearest_relative is blank" do
    @alapp = alapps(:one)
    @alapp.phone_nearest_relative = ""
    assert_not @alapp.save
  end
  test "should not save when phone_nearest_relative is invalid" do
    @alapp = alapps(:one)
    @alapp.phone_nearest_relative = "aaa"
    assert_not @alapp.save
  end
  test "should not save when Driver's license is blank" do
    @alapp = alapps(:one)
    @alapp.driver_lisence_num = ""
    assert_not @alapp.save
  end

  test "should not save when signature is blank" do
    @alapp = alapps(:one)
    @alapp.signature = ""
    assert_not @alapp.save
  end
  test "should not save when today_date is blank" do
    @alapp = alapps(:one)
    @alapp.today_date = ""
    assert_not @alapp.save
  end
  test "should not save when agree_terms is blank" do
    @alapp = alapps(:one)
    @alapp.agree_terms = "false"
    assert_not @alapp.save
  end
end
