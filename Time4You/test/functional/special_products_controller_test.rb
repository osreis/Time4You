require 'test_helper'

class SpecialProductsControllerTest < ActionController::TestCase
  setup do
    @special_product = special_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:special_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create special_product" do
    assert_difference('SpecialProduct.count') do
      post :create, special_product: { quantity: @special_product.quantity, specialPrice: @special_product.specialPrice }
    end

    assert_redirected_to special_product_path(assigns(:special_product))
  end

  test "should show special_product" do
    get :show, id: @special_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @special_product
    assert_response :success
  end

  test "should update special_product" do
    put :update, id: @special_product, special_product: { quantity: @special_product.quantity, specialPrice: @special_product.specialPrice }
    assert_redirected_to special_product_path(assigns(:special_product))
  end

  test "should destroy special_product" do
    assert_difference('SpecialProduct.count', -1) do
      delete :destroy, id: @special_product
    end

    assert_redirected_to special_products_path
  end
end
