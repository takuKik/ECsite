require 'rails_helper'

RSpec.feature "Products", type: :feature do
  given(:product) { create(:base_product) }

  scenario "display each product detail using friendly_id" do
    visit potepan_product_path(product)
    expect(page).to have_title product.name
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price
    expect(page).to have_content product.description
  end

  scenario "display each product user visits a product details page" do
    visit potepan_product_path(product.id)
    expect(page).to have_title product.name
    expect(page).to have_content product.name
    expect(page).to have_content product.display_price
    expect(page).to have_content product.description
  end
end
