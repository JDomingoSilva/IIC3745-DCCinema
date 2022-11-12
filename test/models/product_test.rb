# frozen_string_literal: true

require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  def setup
    @product = products(:one)
    @comestible = Product.create(cost: 12, name: 'ProductoTestComestible',
                                 type: 'Comestible', weight: 20)
    @bebestible = Product.create(cost: 13, name: 'ProductoTestBebestible',
                                 type: 'Bebestible', volum: 20)
    @souvenir = Product.create(cost: 14, name: 'ProductoTestSouvenir',
                               type: 'Souvenir')
  end

  def teardown
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'Get Comestible type' do
    @comestible.set_type
    comestible_check = @comestible.type == 'Comestible'
    assert_equal(true, comestible_check)
  end

  test 'Get Bebestible type' do
    @bebestible.set_type
    bebestible_check = @bebestible.type == 'Bebestible'
    assert_equal(true, bebestible_check)
  end

  test 'Get Souvenir type' do
    @souvenir.set_type
    souvenir_check = @souvenir.type == 'Souvenir'
    assert_equal(true, souvenir_check)
  end

  test 'Invalid class' do
    valid_product = Product.create(cost: 12, name: 'ProductoTestComestible',
                                   type: 'Comestible', weight: 20)
    assert_equal(true, valid_product.valid?)
  end

  test 'Product con parametros validos' do
    valid_product = Product.create(cost: 12, name: 'ProductoTestComestible',
                                   type: 'Comestible', weight: 20)
    assert_equal(true, valid_product.valid?)
  end

  test 'Product sin tipo' do
    invalid_product = Product.create(cost: 12, name: 'ProductoTestComestible', weight: 20)
    assert_equal(false, invalid_product.valid?)
  end

  test 'Product sin nombre' do
    valid_product = Product.create(cost: 12, type: 'Comestible', weight: 20)
    assert_equal(false, valid_product.valid?)
  end
end
