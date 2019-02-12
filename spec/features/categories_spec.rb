require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  given!(:taxonomy) { create(:taxonomy, name: 'Category') }
  given!(:taxon) { taxonomy.root }
  given!(:bag) { create(:taxon, name: 'Bag', taxonomy: taxonomy, parent: taxon) }
  given!(:clothing) { create(:taxon, name: 'Clothing', taxonomy: taxonomy, parent: taxon) }
  given!(:shirts) { create(:taxon, name: 'Shirts', taxonomy: taxonomy, parent: clothing) }
  given!(:product1) { create(:product, name: 'bag', price: 10, taxons: [bag]) }
  given!(:product2) { create(:product, name: 'shirts', price: 20, taxons: [shirts]) }

  background do
    visit potepan_category_path(shirts.id)
  end

  scenario "Appropriate display of categories and products" do
    expect(page).to have_title shirts.name
    within '.side-nav' do
      expect(page).to have_content taxonomy.name
      expect(page).to have_content bag.name
      expect(page).to have_content shirts.name
      expect(page).not_to have_content clothing.name
    end
    within '.productBox' do
      expect(page).to have_content product2.name
      expect(page).to have_content product2.display_price
      expect(page).not_to have_content product1.name
      expect(page).not_to have_content product1.display_price
    end
  end

  scenario "Transit from category link to appropriate product list page" do
    click_on bag.name
    expect(current_path).to eq potepan_category_path(bag.id)
    within '.productBox' do
      expect(page).to have_content product1.name
      expect(page).to have_content product1.display_price
      expect(page).not_to have_content product2.name
      expect(page).not_to have_content product2.display_price
    end
  end

  scenario "Transit from product link to appropriate product details page" do
    click_on product2.name
    expect(current_path).to eq potepan_product_path(product2.id)
  end
end
