require "test_helper"

class CluesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clues_index_url
    assert_response :success
  end
end
