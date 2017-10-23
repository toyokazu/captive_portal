require 'test_helper'

class HashSaltsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get hash_salts_index_url
    assert_response :success
  end

  test "should get new" do
    get hash_salts_new_url
    assert_response :success
  end

  test "should get create" do
    get hash_salts_create_url
    assert_response :success
  end

end
