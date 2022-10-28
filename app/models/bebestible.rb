# frozen_string_literal: true

# bebestible config
class Bebestible < Product
  validates :volum, presence: true, allow_blank: false,
                    numericality: { only_integer: true, greater_than: 0,
                                    message: 'El volumen debe ser mayor que 0' }
  def set_type
    self.type = 'Bebestible'
  end
end
