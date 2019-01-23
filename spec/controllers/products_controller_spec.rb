require 'rails_helper'

RSpec.describe Potepan::ProductsController, type: :controller do
  describe "GET #show" do
    let(:product) { create(:product) }

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
  end
end
