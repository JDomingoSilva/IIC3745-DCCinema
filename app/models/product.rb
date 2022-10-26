# frozen_string_literal: true

# General product config
class Product < ApplicationRecord
  TYPES = %w[Comestible Souvenir Bebestible].freeze
  validates :type, inclusion: { in: TYPES, message: 'Ingresa un tipo de producto valido' }
  validates :name, presence: true
  validates :cost, presence: true,
                   numericality: { only_integer: true, greater_than: 0,
                                   message: 'El costo debe ser mayor que 0' }
  def set_type
    raiser 'You must override this method in each model inheriting from Product!'
  end
end
