require 'test_helper'

class CbpappsControllerTest < ActionController::TestCase
  setup do
    @cbpapp = cbpapps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cbpapps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cbpapp" do
    assert_difference('Cbpapp.count') do
      post :create, cbpapp: { account_number: @cbpapp.account_number, biz_phone: @cbpapp.biz_phone, dob: @cbpapp.dob, first_name: @cbpapp.first_name, grad_date: @cbpapp.grad_date, how_know: @cbpapp.how_know, last_name: @cbpapp.last_name, local_address_city: @cbpapp.local_address_city, local_address_line1: @cbpapp.local_address_line1, local_address_line2: @cbpapp.local_address_line2, local_address_state: @cbpapp.local_address_state, local_address_zip: @cbpapp.local_address_zip, local_home_phone: @cbpapp.local_home_phone, middle_name: @cbpapp.middle_name, mother_maiden: @cbpapp.mother_maiden, non_upenn_email: @cbpapp.non_upenn_email, period: @cbpapp.period, perm_address_city: @cbpapp.perm_address_city, perm_address_country: @cbpapp.perm_address_country, perm_address_line1: @cbpapp.perm_address_line1, perm_address_line2: @cbpapp.perm_address_line2, perm_address_state: @cbpapp.perm_address_state, perm_address_zip: @cbpapp.perm_address_zip, perm_home_phone: @cbpapp.perm_home_phone, ssn: @cbpapp.ssn, student_status: @cbpapp.student_status }
    end

    assert_redirected_to cbpapp_path(assigns(:cbpapp))
  end

  test "should show cbpapp" do
    get :show, id: @cbpapp
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @cbpapp
  #   assert_response :success
  # end

  test "should update cbpapp" do
    patch :update, id: @cbpapp, cbpapp: { account_number: @cbpapp.account_number, biz_phone: @cbpapp.biz_phone, dob: @cbpapp.dob, first_name: @cbpapp.first_name, grad_date: @cbpapp.grad_date, how_know: @cbpapp.how_know, last_name: @cbpapp.last_name, local_address_city: @cbpapp.local_address_city, local_address_line1: @cbpapp.local_address_line1, local_address_line2: @cbpapp.local_address_line2, local_address_state: @cbpapp.local_address_state, local_address_zip: @cbpapp.local_address_zip, local_home_phone: @cbpapp.local_home_phone, middle_name: @cbpapp.middle_name, mother_maiden: @cbpapp.mother_maiden, non_upenn_email: @cbpapp.non_upenn_email, period: @cbpapp.period, perm_address_city: @cbpapp.perm_address_city, perm_address_country: @cbpapp.perm_address_country, perm_address_line1: @cbpapp.perm_address_line1, perm_address_line2: @cbpapp.perm_address_line2, perm_address_state: @cbpapp.perm_address_state, perm_address_zip: @cbpapp.perm_address_zip, perm_home_phone: @cbpapp.perm_home_phone, ssn: @cbpapp.ssn, student_status: @cbpapp.student_status }
    # assert_redirected_to cbpapp_path(assigns(:cbpapp))
    assert_redirected_to cbpapps_path
  end

  test "should destroy cbpapp" do
    assert_difference('Cbpapp.count', -1) do
      delete :destroy, id: @cbpapp
    end

    assert_redirected_to cbpapps_path
  end
end
