require "test_helper"

class EmailHierarchyControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get email_hierarchy_index_url
    assert_response :success
  end
end
