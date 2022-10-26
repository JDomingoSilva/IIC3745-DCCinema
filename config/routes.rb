# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products
  delete 'products/:id', to: 'product#destroy', as: 'bebestible_path'
  get 'products/:id', to: 'product#show', as: 'bebestible'
  delete 'products/:id', to: 'product#destroy', as: 'comestible_path'
  get 'products/:id', to: 'product#show', as: 'comestible'
  delete 'products/:id', to: 'product#destroy', as: 'souvenir_path'
  get 'products/:id', to: 'product#show', as: 'souvenir'
  get 'reservas/new/:sala/:fecha/:horario', to: 'reservas#new', as: 'new_reserva'
  post 'reservas/new/:sala/:fecha/:horario', to: 'reservas#create'
  get 'movie/new'
  post 'movie/new', to: 'movie#post', as: 'create_movie'
  post 'movie_time/new', to: 'movie#create_movie_time', as: 'new_movie_time'
  get '/', to: 'movie#home', as: 'home'
  get 'movies/list', to: 'movie#list_by_date', as: 'movies_by_date'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
