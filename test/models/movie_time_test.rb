# frozen_string_literal: true

require 'test_helper'

class MovieTimeTest < ActiveSupport::TestCase
  def setup
    @movie = Movie.create(title: 'Taken', rated_adult: false)
  end

  def teardown
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'MovieTime con parametros validos' do
    movie_time = MovieTime.new(room: 3, date_start: Date.new(2022, 11, 20),
                               date_end: Date.new(2023, 11, 22), time: 'TANDA',
                               movie_id: @movie.id, place: 'Santiago', language: 'ESPAÑOL')
    assert_equal(true, movie_time.valid?)
  end

  test 'MovieTime sin hora' do
    movie_time = MovieTime.new(room: 3,
                               date_start: Date.new(2022, 11, 20), date_end: Date.new(2023, 11, 22),
                               movie_id: @movie.id, place: 'Santiago', language: 'ESPAÑOL')
    assert_not movie_time.valid?
  end

  test 'MovieTime con hora inválida' do
    movie_time = MovieTime.new(room: 3, time: 'TARDECITO', date_start: Date.new(2022, 11, 20),
                               date_end: Date.new(2023, 11, 22), movie_id: @movie.id,
                               place: 'Santiago', language: 'ESPAÑOL')
    assert_not movie_time.valid?
  end

  test 'MovieTime sin sala' do
    movie_time = MovieTime.new(date_start: Date.new(2022, 11, 20), date_end: Date.new(2023, 11, 22),
                               time: 'TANDA', movie_id: @movie.id, place: 'Santiago',
                               language: 'ESPAÑOL')
    assert_not movie_time.valid?
  end

  test 'MovieTime sin fecha de inicio' do
    movie_time = MovieTime.new(room: 3, date_end: Date.new(2023, 11, 22),
                               time: 'TANDA', movie_id: @movie.id,
                               place: 'Santiago', language: 'ESPAÑOL')
    assert_not movie_time.valid?
  end

  test 'MovieTime sin fecha de fin' do
    movie_time = MovieTime.new(room: 3,
                               date_start: Date.new(2022, 11, 20),
                               time: 'TANDA',
                               movie_id: @movie.id,
                               place: 'Santiago', language: 'ESPAÑOL')
    assert_not movie_time.valid?
  end

  test 'MovieTime sin pelicula' do
    movie_time = MovieTime.new(room: 3, movie_id: 12_312,
                               date_start: Date.new(2022, 11, 20),
                               date_end: Date.new(2023, 11, 22),
                               time: 'TANDA')
    assert_not movie_time.valid?
  end

  test 'MovieTime con fecha de inicio mayor a la de fin' do
    movie_time = MovieTime.new(room: 3,
                               date_start: Date.new(2022, 11, 22),
                               date_end: Date.new(2022, 11, 20),
                               time: 'TANDA',
                               movie_id: @movie.id,
                               place: 'Santiago', language: 'ESPAÑOL')
    assert_not movie_time.valid?
  end

  test ' MovieTime con sala ocupada' do
    movie_time = MovieTime.new(room: 3,
                               date_start: Date.new(2022, 11, 22),
                               date_end: Date.new(2023, 11, 20),
                               time: 'TANDA',
                               movie_id: @movie.id,
                               place: 'Santiago', language: 'ESPAÑOL')
    movie_time.save
    movie2 = Movie.create(title: 'Jujutsu Kaisen 0', rated_adult: false)
    movie_time2 = MovieTime.new(room: 3,
                                date_start: Date.new(2022, 11, 22),
                                date_end: Date.new(2023, 11, 20),
                                time: 'TANDA',
                                movie_id: movie2.id,
                                place: 'Santiago', language: 'ESPAÑOL')
    assert_not movie_time2.valid?
  end

  test ' MovieTime con horario ocupado' do
    movie_time = MovieTime.new(room: 3,
                               date_start: Date.new(2022, 11, 22),
                               date_end: Date.new(2023, 11, 20),
                               time: 'TANDA',
                               movie_id: @movie.id,
                               place: 'Santiago', language: 'ESPAÑOL')
    movie_time.save

    movie_time2 = MovieTime.new(room: 3,
                                date_start: Date.new(2022, 11, 22),
                                date_end: Date.new(2023, 12, 20),
                                time: 'TANDA',
                                movie_id: @movie.id,
                                place: 'Santiago', language: 'ESPAÑOL')
    assert_not movie_time2.valid?
  end
end
