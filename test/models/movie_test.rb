# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  def teardown
    Movie.destroy_all
  end

  test 'Movie adulta con parametros validos' do
    movie = Movie.create(title: 'Matrix', rated_adult: true)
    assert_equal(true, movie.valid?)
  end

  test 'Movie para todas las edades con parametros validos' do
    movie = Movie.create(title: 'Matrix', rated_adult: false)
    assert_equal(true, movie.valid?)
  end

  test 'Movie sin título' do
    movie = Movie.create
    assert_not movie.valid?
  end
end
