require 'test_helper'

class IdentitiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get identities_new_url
    assert_response :success
  end

  test "should get login" do
    get identities_login_url
    assert_response :success
  end

end
