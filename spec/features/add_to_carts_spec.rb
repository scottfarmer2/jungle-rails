require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    # 10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
        )

  end
  scenario "cart should change from 0 to 1" do
    # ACT
    visit root_path

    find_link('Add').trigger("click")

    # DEBUG


    # VERIFY
    expect(page).to have_text('My Cart (0)')
    save_screenshot
    puts page.html
  end
end
