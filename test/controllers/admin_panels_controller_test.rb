require 'test_helper'

class AdminPanelsControllerTest < ActionController::TestCase
  setup do
    @admin_panel = admin_panels(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:admin_panels)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create admin_panel" do
    assert_difference('AdminPanel.count') do
      post :create, admin_panel: {  }
    end

    assert_redirected_to admin_panel_path(assigns(:admin_panel))
  end

  test "should show admin_panel" do
    get :show, id: @admin_panel
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @admin_panel
    assert_response :success
  end

  test "should update admin_panel" do
    patch :update, id: @admin_panel, admin_panel: {  }
    assert_redirected_to admin_panel_path(assigns(:admin_panel))
  end

  test "should destroy admin_panel" do
    assert_difference('AdminPanel.count', -1) do
      delete :destroy, id: @admin_panel
    end

    assert_redirected_to admin_panels_path
  end
end
