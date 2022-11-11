# frozen_string_literal: true

require 'test_helper'

class ReservaTest < ActiveSupport::TestCase
  def setup
    movie = Movie.create(title: 'Matrix', rated_adult: false)
    MovieTime.create(room: 5, date_start: Date.new(2022, 10, 10),
                     date_end: Date.new(2022, 10, 12),
                     time: 'TANDA', movie_id: movie.id)
  end

  def teardown
    Reserva.destroy_all
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'Reserva creada con parametros validos' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 10), asiento: 10, horario: 'TANDA',
                             name: 'Pedro')
    assert_equal(true, reserva.valid?)
  end

  test 'Reserva sin sala' do
    reserva = Reserva.create(fecha: Date.new(2022, 10, 11), asiento: 10, horario: 'TANDA',
                             name: 'Pedro')
    assert_not reserva.valid?
  end

  test 'Reserva sin fecha' do
    reserva = Reserva.create(sala: 5, asiento: 10, horario: 'TANDA',
                             name: 'Pedro')
    assert_not reserva.valid?
  end

  test 'Reserva sin pelicula en esa fecha' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 13), asiento: 10, horario: 'TANDA',
                             name: 'Pedro')
    assert_not reserva.valid?
  end

  test 'Reserva sin asiento' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), horario: 'TANDA',
                             name: 'Pedro')
    assert_not reserva.valid?
  end

  test 'Reserva sin hora' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 10,
                             name: 'Pedro')
    assert_not reserva.valid?
  end

  test 'Reserva sin nombre' do
    reserva = Reserva.create(sala: 5, fecha: Date.new(2022, 10, 11), asiento: 10, horario: 'TANDA')
    assert_not reserva.valid?
  end
end
