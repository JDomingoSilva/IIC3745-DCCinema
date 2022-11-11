# frozen_string_literal: true

class AddAttributesToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :rated_adult, :boolean, null: false
    change_table :movie_times, bulk: true do |t|
      t.string :place, null: false
      t.string :language, null: false
    end
  end
end
