# frozen_string_literal: true

# Controler that manages all actions related to movie creation, room assignment and movie schedule
class MovieController < ApplicationController
  def home; end

  def new
    @movie_times = MovieTime.new
  end

  def post
    title = params[:title]
    image = params[:image]
    rated_adult = params[:rated_adult]
    @movie = Movie.new(title:, image:, rated_adult:)
    if @movie.save
      redirect_to '/movie/new', notice: 'Pelicula creada con exito'
    else
      redirect_to '/movie/new', notice: @movie.errors.messages
    end
  end

  def create_movie_time
    movie_time_params = params.require(:movie_time).permit(:movie_id, :time, :date_start,
                                                           :date_end, :room, :place, :language)
    movie_time = MovieTime.create(movie_time_params)
    if movie_time.persisted?
      redirect_to '/movie/new', notice: 'Pelicula asignada con exito'
    else
      redirect_to '/movie/new', notice: movie_time.errors.messages
    end
  end

  def list_by_language
    @espanol = Movie.includes(:movie_times).where(movie_times: { language: 'ESPAÑOL' })
                    .references(:movie_times)
    @ingles = Movie.includes(:movie_times).where(movie_times: { language: 'INGLÉS' })
                   .references(:movie_times)

    @language_filter = if @language == 'ESPAÑOL'
                         @espanol + @ingles
                       else
                         @ingles + @espanol
                       end
  end

  def list_by_place
    @place_filter = Movie.includes(:movie_times).where(movie_times: { place: @place })
                         .references(:movie_times)
  end

  def list_by_age_rating
    @age_filter = if @age.to_i < 18
                    Movie.where(rated_adult: false)
                  else
                    Movie.all
                  end
  end

  def list_by_date
    @date_filter = Movie.includes(:movie_times).where(['movie_times.date_start <= ? and
                                                   ? <= movie_times.date_end', @date, @date])
                        .references(:movie_times)
  end

  def list_by_filters
    @date = params[:date]
    @age = params[:age]
    @language = params[:language]
    @place = params[:place]

    list_by_date
    list_by_age_rating
    list_by_language
    list_by_place

    @filter = @language_filter.to_a & @date_filter.to_a & @place_filter.to_a & @age_filter.to_a
  end
end
