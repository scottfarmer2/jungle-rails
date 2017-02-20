require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do


    # it { is_expected.to validate_presence_of(:name)}
    # it { is_expected.to validate_presence_of(:price)}
    # it { is_expected.to validate_presence_of(:quantity)}
    # it { is_expected.to validate_presence_of(:category)}


    before(:each) do
      @category = Category.new(name: "hats")
      @product = Product.new(name: "chair", price_cents: 10000, quantity: 6, category: @category)
    end

    it "has a valid product" do
      expect(@product).to be_valid
    end

    it "has a valid product name" do
      @product.name = nil
      expect(@product).to be_invalid
      expect(@product.errors.messages[:name][0] == "can't be blank")
    end

    it "has a valid category" do
      @product.category = nil
      expect(@product).to be_invalid
      expect(@product.errors.messages[:category][0] == "can't be blank")
    end

    it "has a valid price" do
      @product.price_cents = nil
      expect(@product).to be_invalid
      expect(@product.errors.messages[:price_cents][0] == "is not a number")
      expect(@product.errors.messages[:price_cents][1] == "can't be blank")
    end

    it "has a valid quantity" do
      @product.quantity = nil
      expect(@product).to be_invalid
      expect(@product.errors.messages[:quantity][0] == "can't be blank")
    end
  end
end
