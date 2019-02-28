require 'rails_helper'

RSpec.feature "Products", type: :feature do
  given!(:taxon1) { create(:taxon, name: "brand") }
  given!(:taxon2) { create(:taxon, name: "clothing") }
  given!(:product) { create(:product, taxons: [taxon1, taxon2], name: "tote", price: 18.99) }
  given!(:unrelated_product) { create(:product, name: "shirt", price: 19.99) }
  given!(:related_product) { create(:product, taxons: [taxon2], name: "rails", price: 11.99) }

  background do
    visit potepan_product_path(product.id)
  end

  scenario "display each product user visits a product details page" do
    expect(page).to have_title product.name
    within("div.singleProduct") do
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end
    within("div.productsContent") do
      expect(page).to have_content related_product.name
      expect(page).to have_content related_product.display_price
      expect(page).not_to have_content product.name
      expect(page).not_to have_content product.display_price
      expect(page).not_to have_content unrelated_product.name
      expect(page).not_to have_content unrelated_product.display_price
    end
  end

  scenario "Transit from relevant product link to appropriate product details page" do
    click_on related_product.name
    expect(current_path).to eq potepan_product_path(related_product.id)
    within("div.singleProduct") do
      expect(page).to have_content related_product.name
      expect(page).to have_content related_product.display_price
      expect(page).not_to have_content product.name
      expect(page).not_to have_content product.display_price
      expect(page).not_to have_content unrelated_product.name
      expect(page).not_to have_content unrelated_product.display_price
    end
    within("div.productsContent") do
      expect(page).not_to have_content related_product.name
      expect(page).not_to have_content related_product.display_price
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).not_to have_content unrelated_product.name
      expect(page).not_to have_content unrelated_product.display_price
    end
  end
end
