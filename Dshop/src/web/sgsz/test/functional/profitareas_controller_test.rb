require 'test_helper'

class ProfitareasControllerTest < ActionController::TestCase
  setup do
    @profitarea = profitareas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profitareas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profitarea" do
    assert_difference('Profitarea.count') do
      post :create, profitarea: { custstate: @profitarea.custstate, profit: @profitarea.profit }
    end

    assert_redirected_to profitarea_path(assigns(:profitarea))
  end

  test "should show profitarea" do
    get :show, id: @profitarea
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profitarea
    assert_response :success
  end

  test "should update profitarea" do
    put :update, id: @profitarea, profitarea: { custstate: @profitarea.custstate, profit: @profitarea.profit }
    assert_redirected_to profitarea_path(assigns(:profitarea))
  end

  test "should destroy profitarea" do
    assert_difference('Profitarea.count', -1) do
      delete :destroy, id: @profitarea
    end

    assert_redirected_to profitareas_path
  end
end
