require 'test_helper'

class CbpappTest < ActiveSupport::TestCase

  test "successfully create an CBPapplication" do
    @cbpapp = cbpapps(:one)
    assert @cbpapp.save
  end

  test "should not save an CBPapplication without any fields filled" do
    @cbpapp = Cbpapp.new
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without period" do
    @cbpapp = cbpapps(:one)
    @cbpapp.period = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without first name" do
    @cbpapp = cbpapps(:one)
    @cbpapp.first_name = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without last name" do
    @cbpapp = cbpapps(:one)
    @cbpapp.last_name = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication with invalid SSN" do
    @cbpapp = cbpapps(:one)
    @cbpapp.ssn = "123"
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without DoB" do
    @cbpapp = cbpapps(:one)
    @cbpapp.dob = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication with DoB in the future" do
    @cbpapp = cbpapps(:one)
    @cbpapp.dob = "2020-11-20"
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without mother maiden name" do
    @cbpapp = cbpapps(:one)
    @cbpapp.mother_maiden = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without account number" do
    @cbpapp = cbpapps(:one)
    @cbpapp.account_number = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without graduation date" do
    @cbpapp = cbpapps(:one)
    @cbpapp.grad_date = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication with graduation date in the past" do
    @cbpapp = cbpapps(:one)
    @cbpapp.grad_date = "2000-11-20"
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without non-upenn email" do
    @cbpapp = cbpapps(:one)
    @cbpapp.non_upenn_email = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication with invalid non-upenn email(upenn email)" do
    @cbpapp = cbpapps(:one)
    @cbpapp.non_upenn_email = "jose@upenn.edu"
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication with invalid non-upenn email(wrong format)" do
    @cbpapp = cbpapps(:one)
    @cbpapp.non_upenn_email = "jose@dd"
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without how you know this program" do
    @cbpapp = cbpapps(:one)
    @cbpapp.how_know = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication with invalid local address" do
    @cbpapp = cbpapps(:one)
    @cbpapp.local_address_line1 = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication without local home phone" do
    @cbpapp = cbpapps(:one)
    @cbpapp.local_home_phone = ""
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication with invalid local home phone" do
    @cbpapp = cbpapps(:one)
    @cbpapp.local_home_phone = "223"
    assert_not @cbpapp.save
  end

  test "should not save an CBPapplication with invalid permanent address (wrong address)" do
    @cbpapp = cbpapps(:one)
    @cbpapp.perm_address_line1 = "aa"
    assert_not @cbpapp.save
  end

  test "should save an CBPapplication with permanent address (US and no address)" do
    @cbpapp = cbpapps(:one)
    @cbpapp.perm_address_line1 = ""
    @cbpapp.perm_address_line2 = ""
    assert @cbpapp.save
  end

  test "should not save an CBPapplication without student status" do
    @cbpapp = cbpapps(:one)
    @cbpapp.student_status = ""
    assert_not @cbpapp.save
  end

end
