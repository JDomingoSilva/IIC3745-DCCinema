# frozen_string_literal: true

# souvenir config
class Souvenir < Product
  validates :weith, presence: false
  validates :volum, presence: false
  def set_type
    self.type = 'Souvenir'
  end
end
