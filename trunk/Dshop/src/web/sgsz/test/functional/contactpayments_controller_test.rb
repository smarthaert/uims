require 'test_helper'

class ContactpaymentsControllerTest < ActionController::TestCase
  setup do
    @contactpayment = contactpayments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contactpayments)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contactpayment" do
    assert_difference('Contactpayment.count') do
      post :create, contactpayment: { cdate: @contactpayment.cdate, custid: @contactpayment.custid, custname: @contactpayment.custname, inmoney: @contactpayment.inmoney, method: @contactpayment.method, outmoney: @contactpayment.outmoney, proof: @contactpayment.proof, remark: @contactpayment.remark, status: @contactpayment.status, stid: @contactpayment.stid, stname: @contactpayment.stname, strike: @contactpayment.strike, ticketid: @contactpayment.ticketid }
    end

    assert_redirected_to contactpayment_path(assigns(:contactpayment))
  end

  test "should show contactpayment" do
    get :show, id: @contactpayment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contactpayment
    assert_response :success
  end

  test "should update contactpayment" do
    put :update, id: @contactpayment, contactpayment: { cdate: @contactpayment.cdate, custid: @contactpayment.custid, custname: @contactpayment.custname, inmoney: @contactpayment.inmoney, method: @contactpayment.method, outmoney: @contactpayment.outmoney, proof: @contactpayment.proof, remark: @contactpayment.remark, status: @contactpayment.status, stid: @contactpayment.stid, stname: @contactpayment.stname, strike: @contactpayment.strike, ticketid: @contactpayment.ticketid }
    assert_redirected_to contactpayment_path(assigns(:contactpayment))
  end

  test "should destroy contactpayment" do
    assert_difference('Contactpayment.count', -1) do
      delete :destroy, id: @contactpayment
    end

    assert_redirected_to contactpayments_path
  end
end
