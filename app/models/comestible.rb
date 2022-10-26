class Comestible < Product
  validates :weight, presence: true,
                    numericality: { only_integer: true, greater_than: 0,
                                    message: 'El peso debe ser mayor que 0' }
  def set_type # If you don't implement this method, an error will be raised
    self.type = 'Comestible'
  end
end
