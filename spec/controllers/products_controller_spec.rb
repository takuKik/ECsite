require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "GET #show" do
    let!(:taxon1) { create(:taxon, name: "brand") }
    let!(:taxon2) { create(:taxon, name: "clothing") }
    let!(:product) { create(:product, taxons: [taxon1, taxon2], name: "tote") }

    before do
      get :show, params: { id: product.id }
    end

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it "renders a correct page" do
      expect(response).to render_template :show
    end

    it "correctly assigns data to @product" do
      expect(assigns(:product)).to eq product
    end

    context "Test related products" do
      let!(:related_products) { create_list(:product, 4, taxons: [taxon2]) }
      let!(:unrelated_product) { create(:product, name: "shirt") }

      it "Assignment of @related_products" do
        expect(assigns(:related_products)).to match_array(related_products)
      end

      it "Hide non relevant items" do
        expect(assigns(:related_products)).not_to include(unrelated_product)
      end

      it "The item itself is not displayed on the related product" do
        expect(assigns(:related_products)).not_to include(product)
      end

      context "There are 5 or more related products" do
        let!(:related_product) { create(:product, taxons: [taxon1, taxon2], name: "rails") }

        it "Up to 4 related items display" do
          expect(assigns(:related_products).size).to eq 4
        end
      end
    end
  end
end
