# frozen_string_literal: true

# General product config
class Product < ApplicationRecord
  TYPES = %w[Comestible Souvenir Bebestible].freeze
  validates :type, inclusion: { in: TYPES, message: 'Ingresa un tipo de producto valido' }
  validates :name, presence: true, allow_blank: false
  validates :cost, presence: true, allow_blank: false,
                   numericality: { only_integer: true, greater_than: 0,
                                   message: 'El costo debe ser mayor que 0' }

  # raiser 'You must override this method in each model inheriting from Product!'
  def set_type; end
end
