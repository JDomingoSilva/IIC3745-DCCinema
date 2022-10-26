# frozen_string_literal: true

# Comestible config
class Comestible < Product
  validates :weight, presence: true,
                     numericality: { only_integer: true, greater_than: 0,
                                     message: 'El peso debe ser mayor que 0' }
  def set_type
    self.type = 'Comestible'
  end
end
