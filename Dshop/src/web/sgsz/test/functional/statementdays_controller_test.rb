require 'test_helper'

class StatementdaysControllerTest < ActionController::TestCase
  setup do
    @statementday = statementdays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statementdays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create statementday" do
    assert_difference('Statementday.count') do
      post :create, statementday: { date: @statementday.date, inmoney: @statementday.inmoney, method: @statementday.method, outmoney: @statementday.outmoney, strike: @statementday.strike }
    end

    assert_redirected_to statementday_path(assigns(:statementday))
  end

  test "should show statementday" do
    get :show, id: @statementday
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @statementday
    assert_response :success
  end

  test "should update statementday" do
    put :update, id: @statementday, statementday: { date: @statementday.date, inmoney: @statementday.inmoney, method: @statementday.method, outmoney: @statementday.outmoney, strike: @statementday.strike }
    assert_redirected_to statementday_path(assigns(:statementday))
  end

  test "should destroy statementday" do
    assert_difference('Statementday.count', -1) do
      delete :destroy, id: @statementday
    end

    assert_redirected_to statementdays_path
  end
end
