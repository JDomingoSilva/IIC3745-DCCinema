# frozen_string_literal: true

class Product < ApplicationRecord
  validates :type, presence: true
  validates :name, presence: true
  validates :cost, presence: true,
                   numericality: { only_integer: true, greater_than: 0,
                                   message: 'El costo debe ser mayor que 0' }
end

class Bebestible < Product
  validates :volum, presence: true,
                    numericality: { only_integer: true, greater_than: 0,
                                    message: 'El volumen debe ser mayor que 0' }
end

class Comestible < Product
  validates :weith, presence: true,
                    numericality: { only_integer: true, greater_than: 0,
                                    message: 'El peso debe ser mayor que 0' }
end

class Souvenir < Product
  validates :weith, presence: false
  validates :volum, presence: false
end
