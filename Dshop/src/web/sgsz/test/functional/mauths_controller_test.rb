require 'test_helper'

class MauthsControllerTest < ActionController::TestCase
  setup do
    @mauth = mauths(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mauths)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mauth" do
    assert_difference('Mauth.count') do
      post :create, mauth: { cdate: @mauth.cdate, cdkey: @mauth.cdkey, mid: @mauth.mid, remark: @mauth.remark, result: @mauth.result, rid: @mauth.rid, uid: @mauth.uid }
    end

    assert_redirected_to mauth_path(assigns(:mauth))
  end

  test "should show mauth" do
    get :show, id: @mauth
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mauth
    assert_response :success
  end

  test "should update mauth" do
    put :update, id: @mauth, mauth: { cdate: @mauth.cdate, cdkey: @mauth.cdkey, mid: @mauth.mid, remark: @mauth.remark, result: @mauth.result, rid: @mauth.rid, uid: @mauth.uid }
    assert_redirected_to mauth_path(assigns(:mauth))
  end

  test "should destroy mauth" do
    assert_difference('Mauth.count', -1) do
      delete :destroy, id: @mauth
    end

    assert_redirected_to mauths_path
  end
end
