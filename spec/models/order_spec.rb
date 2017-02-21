require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @category = Category.new(name: "hats")
      @product1 = Product.create!(name: "chair",
                                  price: 10000,
                                  quantity: 6,
                                  category: @category)
      @product2 = Product.create!(name: "hat",
                                  price: 6000,
                                  quantity: 7,
                                  category: @category)
      @product3 = Product.create!(name: "pants",
                                  price: 400,
                                  quantity: 30,
                                  category: @category)
      # Setup at least one product that will NOT be in the order
    end
    # pending test 1
    it 'deducts quantity from products based on their line item quantities' do
      # TODO: Implement based on hints below
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(email: 'weridd@dick.com',
                         total_cents: 10000,
                         stripe_charge_id: 'test', # returned by stripe
                        )
      # 2. build line items on @order
        @quantity1 =3
        @order.line_items.new(
          product: @product1,
          quantity:@quantity1,
          item_price: @product1.price,
          total_price: @product1.price * @quantity1)

      # ...
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      # ...

      expect(@product1.quantity).to eq(3)
    end
    # pending test 2
    xit 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
    end
  end
end
