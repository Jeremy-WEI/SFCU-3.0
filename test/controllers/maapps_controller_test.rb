require 'test_helper'

class MaappsControllerTest < ActionController::TestCase
  setup do
    @maapp = maapps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:maapps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create maapp" do
    assert_difference('Maapp.count') do
      post :create, maapp: { w8ben_form: @maapp.w8ben_form, address_on_checks: @maapp.address_on_checks, alter_email: @maapp.alter_email, apply_date: @maapp.apply_date, check_delivery: @maapp.check_delivery, check_type: @maapp.check_type, checking_account: @maapp.checking_account, color: @maapp.color, courtesy_pay: @maapp.courtesy_pay, dob: @maapp.dob, doc_id: @maapp.doc_id, doc_type: @maapp.doc_type, file_id1: @maapp.file_id1, file_id2: @maapp.file_id2, first_name: @maapp.first_name, grad_year: @maapp.grad_year, home_phone: @maapp.home_phone, last_name: @maapp.last_name, local_address_city: @maapp.local_address_city, local_address_line1: @maapp.local_address_line1, local_address_line2: @maapp.local_address_line2, local_address_state: @maapp.local_address_state, local_address_zip: @maapp.local_address_zip, middle_name: @maapp.middle_name, mobile_phone: @maapp.mobile_phone, order_checks: @maapp.order_checks, penn_affiliation: @maapp.penn_affiliation, penn_email: @maapp.penn_email, penn_id: @maapp.penn_id, penncard_link: @maapp.penncard_link, penncard_number: @maapp.penncard_number, perm_address_city: @maapp.perm_address_city, perm_address_line1: @maapp.perm_address_line1, perm_address_line2: @maapp.perm_address_line2, perm_address_state: @maapp.perm_address_state, perm_address_zip: @maapp.perm_address_zip, signature: @maapp.signature, ssn: @maapp.ssn, statement_type: @maapp.statement_type, student_status: @maapp.student_status, visa_checkcard: @maapp.visa_checkcard, visa_delivery: @maapp.visa_delivery, visa_pin: @maapp.visa_pin }
    end

    assert_redirected_to maapp_path(assigns(:maapp))
  end

  test "should show maapp" do
    get :show, id: @maapp
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @maapp
  #   assert_response :success
  # end

  test "should update maapp" do
    patch :update, id: @maapp, maapp: { w8ben_form: @maapp.w8ben_form, address_on_checks: @maapp.address_on_checks, alter_email: @maapp.alter_email, apply_date: @maapp.apply_date, check_delivery: @maapp.check_delivery, check_type: @maapp.check_type, checking_account: @maapp.checking_account, color: @maapp.color, courtesy_pay: @maapp.courtesy_pay, dob: @maapp.dob, doc_id: @maapp.doc_id, doc_type: @maapp.doc_type, file_id1: @maapp.file_id1, file_id2: @maapp.file_id2, first_name: @maapp.first_name, grad_year: @maapp.grad_year, home_phone: @maapp.home_phone, last_name: @maapp.last_name, local_address_city: @maapp.local_address_city, local_address_line1: @maapp.local_address_line1, local_address_line2: @maapp.local_address_line2, local_address_state: @maapp.local_address_state, local_address_zip: @maapp.local_address_zip, middle_name: @maapp.middle_name, mobile_phone: @maapp.mobile_phone, order_checks: @maapp.order_checks, penn_affiliation: @maapp.penn_affiliation, penn_email: @maapp.penn_email, penn_id: @maapp.penn_id, penncard_link: @maapp.penncard_link, penncard_number: @maapp.penncard_number, perm_address_city: @maapp.perm_address_city, perm_address_line1: @maapp.perm_address_line1, perm_address_line2: @maapp.perm_address_line2, perm_address_state: @maapp.perm_address_state, perm_address_zip: @maapp.perm_address_zip, signature: @maapp.signature, ssn: @maapp.ssn, statement_type: @maapp.statement_type, student_status: @maapp.student_status, visa_checkcard: @maapp.visa_checkcard, visa_delivery: @maapp.visa_delivery, visa_pin: @maapp.visa_pin }
    # assert_redirected_to maapp_path(assigns(:maapp))
    assert_redirected_to maapps_path
  end

  test "should destroy maapp" do
    assert_difference('Maapp.count', -1) do
      delete :destroy, id: @maapp
    end

    assert_redirected_to maapps_path
  end
end
