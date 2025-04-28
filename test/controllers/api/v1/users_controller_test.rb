require "test_helper"

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get responses" do
    get api_v1_users_responses_url
    assert_response :success
  end
end
