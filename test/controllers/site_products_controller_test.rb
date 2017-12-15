require 'test_helper'

class SiteProductsControllerTest < ActionController::TestCase
  test "should get product_id:integer" do
    get :product_id:integer
    assert_response :success
  end

  test "should get site:references" do
    get :site:references
    assert_response :success
  end

end
