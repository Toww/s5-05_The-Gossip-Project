require 'test_helper'

class HomepageControllerTest < ActionDispatch::IntegrationTest
  test "should get homepage" do
    get homepage_homepage_url
    assert_response :success
  end

end
