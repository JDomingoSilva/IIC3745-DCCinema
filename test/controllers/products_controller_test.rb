# frozen_string_literal: true

require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:one)
    @comestible = Product.create(cost: 12, name: 'ProductoTestComestible',
                                 type: 'Comestible', weight: 20)
    @bebestible = Product.create(cost: 13, name: 'ProductoTestBebestible',
                                 type: 'Bebestible', volum: 20)
    @souvenir = Product.create(cost: 14, name: 'ProductoTestSouvenir',
                               type: 'Souvenir')
  end

  test 'should get  bebestible product' do
    get format('/products'), params: { filter: { type: 'Bebestible' } }
    assert_response :success
  end
  test 'should check  comestible product' do
    get format('/products'), params: { comestible: { type: 'Comestible' } }
    assert_response :success
  end
  test 'should check  Bebestible product' do
    get format('/products'), params: { bebestible: { type: 'Bebestible' } }
    assert_response :success
  end
  test 'should get  Souvenir product' do
    get format('/products'), params: { souvenir: { type: 'Souvenir' } }
    assert_response :success
  end

  test 'should get index' do
    get products_url
    assert_response :success
  end

  test 'should get new' do
    get new_product_url
    assert_response :success
  end

  test 'should create product' do
    assert_difference('Product.count') do
      post products_url,
           params: { product: { cost: @product.cost, name: @product.name, type: @comestible.type,
                                volum: @product.volum, weight: @product.weight } }
    end

    assert_redirected_to product_url(Product.last)
  end

  test 'should show product' do
    get product_url(@product)
    assert_response :success
  end

  test 'should get edit' do
    get edit_product_url(@product)
    assert_response :success
  end

  test 'should update product' do
    patch product_url(@product),
          params: { product: { cost: @product.cost, name: @product.name, type: 'Comestible',
                               volum: @product.volum, weight: @product.weight } }
    assert_redirected_to product_url(@product)
  end

  test 'should destroy product' do
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
