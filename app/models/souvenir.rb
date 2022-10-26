class Souvenir < Product
  validates :weith, presence: false
  validates :volum, presence: false
  def set_type # If you don't implement this method, an error will be raised
    self.type = 'Souvenir'
  end
end
  