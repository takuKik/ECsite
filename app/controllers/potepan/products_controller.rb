class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.includes(product_properties: :property).friendly.find(params[:id])
  end
end
