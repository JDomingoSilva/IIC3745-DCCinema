# frozen_string_literal: true

require 'test_helper'

class MovieControllerTest < ActionDispatch::IntegrationTest
  def setup; end

  # def teardown
  #   Product.destroy_all
  #   Reserva.destroy_all
  #   MovieTime.destroy_all
  #   Movie.destroy_all
  # end

  test 'should get new' do
    get movie_new_url
    assert_response :success
  end

  test 'Agrega una nueva pelicula' do
    post format('/movie/new'),
         params: { 'title' => 'hola123', 'rated_adult' => 'false', 'commit' => 'Crear' }
    assert_redirected_to '/movie/new'
  end

  test 'Se trata de agregar una pelicula sin titulo' do
    post format('/movie/new'),
         params: { 'rated_adult' => 'false', 'commit' => 'Crear' }
    assert_redirected_to '/movie/new'
  end
end
