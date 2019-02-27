Spree::Product.class_eval do
  scope :related_products, -> (product) do
    in_taxons(product.taxons).includes(master: [:images, :default_price]).where.not(id: product.id).distinct
  end
end
