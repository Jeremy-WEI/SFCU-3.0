require 'test_helper'

class UlappsControllerTest < ActionController::TestCase
  setup do
    @ulapp = ulapps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ulapps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ulapp" do
    assert_difference('Ulapp.count') do
      post :create, ulapp: { account_type1: @ulapp.account_type1, account_type2: @ulapp.account_type2, account_type3: @ulapp.account_type3, additional: @ulapp.additional, addr1: @ulapp.addr1, addr2: @ulapp.addr2, addr3: @ulapp.addr3, alter_number: @ulapp.alter_number, alter_type: @ulapp.alter_type, amount1: @ulapp.amount1, amount2: @ulapp.amount2, amount3: @ulapp.amount3, amount: @ulapp.amount, avg1: @ulapp.avg1, avg2: @ulapp.avg2, avg3: @ulapp.avg3, avg4: @ulapp.avg4, balance1: @ulapp.balance1, balance2: @ulapp.balance2, balance3: @ulapp.balance3, cbalance1: @ulapp.cbalance1, cbalance2: @ulapp.cbalance2, cbalance3: @ulapp.cbalance3, cbalance4: @ulapp.cbalance4, continue2: @ulapp.continue2, continue: @ulapp.continue, creditor1: @ulapp.creditor1, creditor2: @ulapp.creditor2, creditor3: @ulapp.creditor3, creditor4: @ulapp.creditor4, creditor_type1: @ulapp.creditor_type1, creditor_type2: @ulapp.creditor_type2, depository1: @ulapp.depository1, depository2: @ulapp.depository2, depository3: @ulapp.depository3, disbursement2: @ulapp.disbursement2, disbursement: @ulapp.disbursement, dob: @ulapp.dob, e_mail: @ulapp.e_mail, employee2_address_city: @ulapp.employee2_address_city, employee2_address_line1: @ulapp.employee2_address_line1, employee2_address_line2: @ulapp.employee2_address_line2, employee2_address_state: @ulapp.employee2_address_state, employee2_address_zip: @ulapp.employee2_address_zip, employee2_country: @ulapp.employee2_country, employee_address_city: @ulapp.employee_address_city, employee_address_line1: @ulapp.employee_address_line1, employee_address_line2: @ulapp.employee_address_line2, employee_address_state: @ulapp.employee_address_state, employee_address_zip: @ulapp.employee_address_zip, employee_country: @ulapp.employee_country, employer2: @ulapp.employer2, employer: @ulapp.employer, expenses: @ulapp.expenses, file1: @ulapp.file1, file2: @ulapp.file2, file3: @ulapp.file3, file4: @ulapp.file4, file5: @ulapp.file5, file6: @ulapp.file6, first_name: @ulapp.first_name, first_payment1: @ulapp.first_payment1, first_payment2: @ulapp.first_payment2, graduation: @ulapp.graduation, grosspay2: @ulapp.grosspay2, grosspay: @ulapp.grosspay, joint_applicant: @ulapp.joint_applicant, last_name: @ulapp.last_name, last_payment1: @ulapp.last_payment1, last_payment2: @ulapp.last_payment2, loan_creditor1: @ulapp.loan_creditor1, loan_creditor2: @ulapp.loan_creditor2, local_address_city: @ulapp.local_address_city, local_address_line1: @ulapp.local_address_line1, local_address_line2: @ulapp.local_address_line2, local_address_state: @ulapp.local_address_state, local_address_zip: @ulapp.local_address_zip, local_country: @ulapp.local_country, market_value1: @ulapp.market_value1, market_value2: @ulapp.market_value2, market_value3: @ulapp.market_value3, monthly1: @ulapp.monthly1, monthly2: @ulapp.monthly2, mothers: @ulapp.mothers, name_relative: @ulapp.name_relative, nextpayment1: @ulapp.nextpayment1, nextpayment2: @ulapp.nextpayment2, nextpayment3: @ulapp.nextpayment3, nextpayment4: @ulapp.nextpayment4, no2: @ulapp.no2, no: @ulapp.no, past_due1: @ulapp.past_due1, past_due2: @ulapp.past_due2, pastdue1: @ulapp.pastdue1, pastdue2: @ulapp.pastdue2, pastdue3: @ulapp.pastdue3, pastdue4: @ulapp.pastdue4, perm_address_city: @ulapp.perm_address_city, perm_address_line1: @ulapp.perm_address_line1, perm_address_line2: @ulapp.perm_address_line2, perm_address_state: @ulapp.perm_address_state, perm_address_zip: @ulapp.perm_address_zip, perm_country: @ulapp.perm_country, phone_number: @ulapp.phone_number, phone_relative: @ulapp.phone_relative, phone_type: @ulapp.phone_type, pledged1: @ulapp.pledged1, pledged2: @ulapp.pledged2, pledged3: @ulapp.pledged3, position2: @ulapp.position2, position: @ulapp.position, purpose: @ulapp.purpose, sfcu_account: @ulapp.sfcu_account, signature: @ulapp.signature, source1: @ulapp.source1, source2: @ulapp.source2, source3: @ulapp.source3, ssn: @ulapp.ssn, startingdate2: @ulapp.startingdate2, startingdate: @ulapp.startingdate, supervisor2_firstname: @ulapp.supervisor2_firstname, supervisor2_lastname: @ulapp.supervisor2_lastname, supervisor_firstname: @ulapp.supervisor_firstname, supervisor_lastname: @ulapp.supervisor_lastname, credit_type: @ulapp.credit_type, yesorno: @ulapp.yesorno }
    end

    assert_redirected_to ulapp_path(assigns(:ulapp))
  end

  test "should show ulapp" do
    get :show, id: @ulapp
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @ulapp
  #   assert_response :success
  # end

  test "should update ulapp" do
    patch :update, id: @ulapp, ulapp: { account_type1: @ulapp.account_type1, account_type2: @ulapp.account_type2, account_type3: @ulapp.account_type3, additional: @ulapp.additional, addr1: @ulapp.addr1, addr2: @ulapp.addr2, addr3: @ulapp.addr3, alter_number: @ulapp.alter_number, alter_type: @ulapp.alter_type, amount1: @ulapp.amount1, amount2: @ulapp.amount2, amount3: @ulapp.amount3, amount: @ulapp.amount, avg1: @ulapp.avg1, avg2: @ulapp.avg2, avg3: @ulapp.avg3, avg4: @ulapp.avg4, balance1: @ulapp.balance1, balance2: @ulapp.balance2, balance3: @ulapp.balance3, cbalance1: @ulapp.cbalance1, cbalance2: @ulapp.cbalance2, cbalance3: @ulapp.cbalance3, cbalance4: @ulapp.cbalance4, continue2: @ulapp.continue2, continue: @ulapp.continue, creditor1: @ulapp.creditor1, creditor2: @ulapp.creditor2, creditor3: @ulapp.creditor3, creditor4: @ulapp.creditor4, creditor_type1: @ulapp.creditor_type1, creditor_type2: @ulapp.creditor_type2, depository1: @ulapp.depository1, depository2: @ulapp.depository2, depository3: @ulapp.depository3, disbursement2: @ulapp.disbursement2, disbursement: @ulapp.disbursement, dob: @ulapp.dob, e_mail: @ulapp.e_mail, employee2_address_city: @ulapp.employee2_address_city, employee2_address_line1: @ulapp.employee2_address_line1, employee2_address_line2: @ulapp.employee2_address_line2, employee2_address_state: @ulapp.employee2_address_state, employee2_address_zip: @ulapp.employee2_address_zip, employee2_country: @ulapp.employee2_country, employee_address_city: @ulapp.employee_address_city, employee_address_line1: @ulapp.employee_address_line1, employee_address_line2: @ulapp.employee_address_line2, employee_address_state: @ulapp.employee_address_state, employee_address_zip: @ulapp.employee_address_zip, employee_country: @ulapp.employee_country, employer2: @ulapp.employer2, employer: @ulapp.employer, expenses: @ulapp.expenses, file1: @ulapp.file1, file2: @ulapp.file2, file3: @ulapp.file3, file4: @ulapp.file4, file5: @ulapp.file5, file6: @ulapp.file6, first_name: @ulapp.first_name, first_payment1: @ulapp.first_payment1, first_payment2: @ulapp.first_payment2, graduation: @ulapp.graduation, grosspay2: @ulapp.grosspay2, grosspay: @ulapp.grosspay, joint_applicant: @ulapp.joint_applicant, last_name: @ulapp.last_name, last_payment1: @ulapp.last_payment1, last_payment2: @ulapp.last_payment2, loan_creditor1: @ulapp.loan_creditor1, loan_creditor2: @ulapp.loan_creditor2, local_address_city: @ulapp.local_address_city, local_address_line1: @ulapp.local_address_line1, local_address_line2: @ulapp.local_address_line2, local_address_state: @ulapp.local_address_state, local_address_zip: @ulapp.local_address_zip, local_country: @ulapp.local_country, market_value1: @ulapp.market_value1, market_value2: @ulapp.market_value2, market_value3: @ulapp.market_value3, monthly1: @ulapp.monthly1, monthly2: @ulapp.monthly2, mothers: @ulapp.mothers, name_relative: @ulapp.name_relative, nextpayment1: @ulapp.nextpayment1, nextpayment2: @ulapp.nextpayment2, nextpayment3: @ulapp.nextpayment3, nextpayment4: @ulapp.nextpayment4, no2: @ulapp.no2, no: @ulapp.no, past_due1: @ulapp.past_due1, past_due2: @ulapp.past_due2, pastdue1: @ulapp.pastdue1, pastdue2: @ulapp.pastdue2, pastdue3: @ulapp.pastdue3, pastdue4: @ulapp.pastdue4, perm_address_city: @ulapp.perm_address_city, perm_address_line1: @ulapp.perm_address_line1, perm_address_line2: @ulapp.perm_address_line2, perm_address_state: @ulapp.perm_address_state, perm_address_zip: @ulapp.perm_address_zip, perm_country: @ulapp.perm_country, phone_number: @ulapp.phone_number, phone_relative: @ulapp.phone_relative, phone_type: @ulapp.phone_type, pledged1: @ulapp.pledged1, pledged2: @ulapp.pledged2, pledged3: @ulapp.pledged3, position2: @ulapp.position2, position: @ulapp.position, purpose: @ulapp.purpose, sfcu_account: @ulapp.sfcu_account, signature: @ulapp.signature, source1: @ulapp.source1, source2: @ulapp.source2, source3: @ulapp.source3, ssn: @ulapp.ssn, startingdate2: @ulapp.startingdate2, startingdate: @ulapp.startingdate, supervisor2_firstname: @ulapp.supervisor2_firstname, supervisor2_lastname: @ulapp.supervisor2_lastname, supervisor_firstname: @ulapp.supervisor_firstname, supervisor_lastname: @ulapp.supervisor_lastname, credit_type: @ulapp.credit_type, yesorno: @ulapp.yesorno }
    # assert_redirected_to ulapp_path(assigns(:ulapp))
    assert_redirected_to ulapps_path
  end

  test "should destroy ulapp" do
    assert_difference('Ulapp.count', -1) do
      delete :destroy, id: @ulapp
    end

    assert_redirected_to ulapps_path
  end
end
