require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @product = Product.new(
      name: 'Item',
      price: 1,
      quantity: 1
    )
  end

  describe "Validations" do
    it "is valid with valid attributes" do
      expect(@product).to be_valid
    end

    it "is not valid without a name" do
      @product.name = nil

      expect(@product).to_not be_valid
    end

    it "is not valid without a price" do
      @product.price = nil

      expect(@product).to_not be_valid
    end

    it "is not valid without a quantity" do
      @product.quantity = nil

      expect(@product).to_not be_valid
    end
  end

  describe "#sold_out?" do
    it "is sold out if there are 0 left" do
      @product.quantity = 0
      @product.save
      
      expect(@product.sold_out?).to be true
    end

    it "is not sold out if there is 1 left" do
      @product.quantity = 1
      @product.save

      expect(@product.sold_out?).to be false
    end

    it "is sold out if there are fewer than 0 remaining" do
      @product.quantity = -1
      @product.save

      expect(@product.sold_out?).to be true
    end
  end

  describe ".low_stock" do
    it "returns the products with a quantity less than 3" do
      Product.create(name: 'Item', price: 1, quantity: 1)
      Product.create(name: 'Item', price: 1, quantity: 2)
      Product.create(name: 'Item', price: 1, quantity: 3)

      products = Product.low_stock()

      expect(products.length).to be 2
    end
  end
end
