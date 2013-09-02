require 'test_helper'

class SellcostgiftsControllerTest < ActionController::TestCase
  setup do
    @sellcostgift = sellcostgifts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sellcostgifts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sellcostgift" do
    assert_difference('Sellcostgift.count') do
      post :create, sellcostgift: { additional: @sellcostgift.additional, cost: @sellcostgift.cost }
    end

    assert_redirected_to sellcostgift_path(assigns(:sellcostgift))
  end

  test "should show sellcostgift" do
    get :show, id: @sellcostgift
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sellcostgift
    assert_response :success
  end

  test "should update sellcostgift" do
    put :update, id: @sellcostgift, sellcostgift: { additional: @sellcostgift.additional, cost: @sellcostgift.cost }
    assert_redirected_to sellcostgift_path(assigns(:sellcostgift))
  end

  test "should destroy sellcostgift" do
    assert_difference('Sellcostgift.count', -1) do
      delete :destroy, id: @sellcostgift
    end

    assert_redirected_to sellcostgifts_path
  end
end
