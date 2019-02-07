require 'rails_helper'

RSpec.describe Potepan::CategoriesController, type: :controller do
  describe "#show" do
    let(:taxonomy) { create(:taxonomy) }
    let(:taxon) { taxonomy.root }
    let(:child_taxon) { create(:taxon, taxonomy: taxonomy, parent: taxon) }
    let(:product) { create(:product, taxons: [child_taxon]) }

    before do
      get :show, params: { id: child_taxon.id }
    end

    it "Success of the response" do
      expect(response).to be_success
    end

    it "renders a correct page" do
      expect(response).to render_template(:show)
    end

    it "correctly assigns data to @taxonomies" do
      expect(assigns(:taxonomies)).to match_array(taxonomy)
    end

    it "correctly assigns data to @taxon" do
      expect(assigns(:taxon)).to eq child_taxon
    end

    it "correctly assigns data to @products" do
      expect(assigns(:products)).to match_array(product)
    end
  end
end
