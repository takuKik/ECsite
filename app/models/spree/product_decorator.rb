module Spree::ProductDecorator
  def self.prepended(base)
    base.scope :related_products, -> (product) do
      in_taxons(product.taxons).includes(master: [:images, :default_price]).where.not(id: product.id).distinct
    end
  end

  Spree::Product.prepend self
end
