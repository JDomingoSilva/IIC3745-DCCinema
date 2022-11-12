# frozen_string_literal: true

require 'test_helper'

class MovieControllerTest < ActionDispatch::IntegrationTest
  def setup
    @movie = Movie.create(title: 'Taken', rated_adult: false)
  end

  def teardown
    Product.destroy_all
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end

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
  test 'Se agrega un movie time correctamente' do
    post format('/movie_time/new'),
         params: { 'movie_time' => { 'movie_id' => @movie.id, 'language' => 'ESPAÑOL',
                                     'time' => 'MATINÉ', 'date_start' => '2022-11-17',
                                     'date_end' => '2022-11-30', 'place' => 'Santiago',
                                     'room' => '1' }, 'commit' => 'Asignar' }
    assert_redirected_to '/movie/new'
  end
  test 'No se agrega un movie time correctamente' do
    post format('/movie_time/new'),
         params: { 'movie_time' => { 'language' => 'ESPAÑOL',
                                     'time' => 'MATINÉ', 'date_start' => '2022-11-17',
                                     'date_end' => '2022-11-30', 'place' => 'Santiago',
                                     'room' => '1' }, 'commit' => 'Asignar' }
    assert_redirected_to '/movie/new'
  end
  test 'Se filtran las peliculas' do
    get format('/movies/list'),
        params: { 'date' => '2022-11-11', 'age' => '123', 'place' => 'Santiago',
                  'language' => 'INGLÉS', 'commit' => 'Buscar' }
    assert_response :success
  end
  test 'Se filtran las peliculas para menores de 18 años' do
    get format('/movies/list'),
        params: { 'date' => '2022-11-11', 'age' => '2', 'place' => 'Santiago',
                  'language' => 'INGLÉS', 'commit' => 'Buscar' }
    assert_response :success
  end
  test 'Se filtran las peliculas en español' do
    get format('/movies/list'),
        params: { 'date' => '2022-11-11', 'age' => '2', 'place' => 'Santiago',
                  'language' => 'ESPAÑOL', 'commit' => 'Buscar' }
    assert_response :success
  end
end
