class Potepan::ProductsController < ApplicationController
  def show
    @product = Spree::Product.includes(product_properties: :property).find(params[:id])
    @related_products = Spree::Product.in_taxons(@product.taxons).includes(master: [:images, :default_price]).where.not(id: @product.id).distinct.limit(4)
  end
end
