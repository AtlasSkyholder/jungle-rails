require 'rails_helper'

RSpec.feature "should be able to click on a specific product to display the product details page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end

    visit root_path
  end

  scenario "They see all products and click first item details" do
    save_screenshot("before-details-btn.png")
    find('.product .actions a.btn', match: :first).click
    sleep 1
    expect(page).to have_css('article.product-detail')
    save_screenshot("after-details-btn.png")
  end

  scenario "They see all products and click first item header" do
    save_screenshot("before-product-header.png")
    puts page.html
    find('article.product header', match: :first).click
    sleep 1
    expect(page).to have_css('article.product-detail')
    save_screenshot("after-product-header.png")
  end
end
