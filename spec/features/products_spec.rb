require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe "show details of a product" do
    let(:product) { create(:product) }

    scenario "user visits a product details page" do
      visit potepan_product_path(product.id)
      expect(page).to have_content product.name
      expect(page).to have_content product.display_price
      expect(page).to have_content product.description
    end
  end
end
