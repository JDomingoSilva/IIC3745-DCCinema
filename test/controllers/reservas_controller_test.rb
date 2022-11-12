# frozen_string_literal: true

require 'test_helper'

class ReservasControllerTest < ActionDispatch::IntegrationTest
  def setup
    movie = Movie.create(title: 'Matrix-Dos', rated_adult: false)
    MovieTime.create(room: 5, date_start: Date.new(2000, 11, 10),
                     date_end: Date.new(2010, 11, 12), time: 'TANDA',
                     movie_id: movie.id,
                     place: 'Santiago', language: 'ESPAÑOL')
    Reserva.create(name: 'reserva', asiento: 'A-5', sala: '5', fecha: '2001-11-11',
                   horario: 'TANDA')
  end

  def teardown
    MovieTime.destroy_all
    Movie.destroy_all
  end

  test 'Posting a new reserva' do
    assert_difference 'Reserva.count' do
      post new_reserva_url(5, '2000-11-11', 'TANDA'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end

  test 'Nueva reserva sin horario' do
    assert_difference('Reserva.count', 0) do
      post new_reserva_url(5, '2000-11-12', ' '),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end
  test 'Nueva reserva con un horario invalido' do
    assert_difference('Reserva.count', 0) do
      post new_reserva_url(5, '2001-11-12', 'Hola'),
           params: { reservation_seats: 'C-3', name: 'Diego' }
    end
  end
  test 'Nueva reserva sin nombre' do
    assert_difference('Reserva.count', 0) do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'C-3' }
    end
  end
  test 'Nueva reserva sin asiento' do
    assert_difference('Reserva.count', 0) do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: '', name: 'Diego' }
    end
  end
  test 'Nueva reserva con asiento invalido' do
    assert_difference('Reserva.count', 0) do
      post new_reserva_url(5, '2000-11-12', 'TANDA'),
           params: { reservation_seats: 'ZZ-3', name: 'Diego' }
    end
  end
  test 'Mostrar las reservas' do
    get(new_reserva_url(5, '2000-11-11', 'TANDA'))
    assert_response :success
  end
end
