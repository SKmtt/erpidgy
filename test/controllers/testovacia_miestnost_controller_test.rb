require 'test_helper'

class TestovaciaMiestnostControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get testovacia_miestnost_index_url
    assert_response :success
  end

end
