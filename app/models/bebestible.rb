class Bebestible < Product
  validates :volum, presence: true,
                    numericality: { only_integer: true, greater_than: 0,
                                    message: 'El volumen debe ser mayor que 0' }
  def set_type # If you don't implement this method, an error will be raised
    self.type = 'Bebestible'
  end
end
