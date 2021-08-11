require 'test_helper'

class Servers::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get servers_dashboard_index_url
    assert_response :success
  end

end
