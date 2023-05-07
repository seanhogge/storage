require "test_helper"

class AttachmentControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get attachment_destroy_url
    assert_response :success
  end
end
