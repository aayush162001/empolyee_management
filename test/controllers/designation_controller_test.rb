require "test_helper"

class DesignationControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get designation_index_url
    assert_response :success
  end
end
