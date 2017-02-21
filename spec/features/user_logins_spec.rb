require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  before :each do
    @password = "123456789abcdefghijklmnopqrstuvwxyz"
    @user = User.create!(id: 1,
                        first_name: "John",
                        last_name: "Wayne",
                        email: "test@test.com",
                        email_confirmation: "test@test.com",
                        password: @password,
                        password_confirmation: @password
                        )

  end

  scenario "login works" do
    # ACT
    visit login_path

    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password
    click_button 'Submit'
    # DEBUG


    # VERIFY
    expect(page).to have_text('Logout')
    save_screenshot
    puts page.html
  end
end