require 'test_helper'

class DataRenderingControllerTest < ActionController::TestCase
  test "should get styles" do
    get :styles
    assert_response :success
  end

  test "should get images" do
    get :images
    assert_response :success
  end

end
