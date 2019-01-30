require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe "show details of a product" do
    given(:product)           { create(:product) }
    given(:property)          { create(:property) }
    given!(:product_property) { create(:product_property, product: product, property: property) }

    it "display each product user visits a product details page" do
      visit potepan_product_path(product.id)
      expect(page).to have_title   product.name
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
      expect(page).to have_content product_property.value
    end
  end
end
