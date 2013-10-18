require 'test_helper'

class ActiveDevicesControllerTest < ActionController::TestCase
  setup do
    @active_device = active_devices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:active_devices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create active_device" do
    assert_difference('ActiveDevice.count') do
      post :create, active_device: { device: @active_device.device, serail: @active_device.serail }
    end

    assert_redirected_to active_device_path(assigns(:active_device))
  end

  test "should show active_device" do
    get :show, id: @active_device
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @active_device
    assert_response :success
  end

  test "should update active_device" do
    patch :update, id: @active_device, active_device: { device: @active_device.device, serail: @active_device.serail }
    assert_redirected_to active_device_path(assigns(:active_device))
  end

  test "should destroy active_device" do
    assert_difference('ActiveDevice.count', -1) do
      delete :destroy, id: @active_device
    end

    assert_redirected_to active_devices_path
  end
end
