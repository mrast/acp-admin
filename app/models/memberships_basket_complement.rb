class MembershipsBasketComplement < ActiveRecord::Base
  include HasSeasons

  belongs_to :membership
  belongs_to :basket_complement

  validates :basket_complement_id, uniqueness: { scope: :membership_id }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }, presence: true

  before_validation do
    self.price ||= basket_complement&.price
  end

  def total_price
    quantity * price
  end

  def season_quantity(delivery)
    out_of_season_quantity(delivery) || quantity
  end
end
