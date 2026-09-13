require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get root page" do
    get root_url

    assert_response :success
    assert_select "h1", "Provider Dashboard"
  end
end
