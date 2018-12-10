class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true

  def sold_out?
    quantity <= 0
  end

  def self.low_stock 
    Product.where(quantity: 1..2)
  end
end
