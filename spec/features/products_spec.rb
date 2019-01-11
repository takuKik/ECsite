require 'rails_helper'

RSpec.feature "Products", type: :feature do
  describe "show details of a product" do
    let(:product) { create(:product, sku: "ROR-00012") }

    scenario "user visits a product details page" do
      visit potepan_product_path(product.id)
      expect(page).to have_content product.name, count: 3
      expect(page).to have_content product.display_price, count: 1
      expect(page).to have_content product.description, count: 2
    end
  end
end
