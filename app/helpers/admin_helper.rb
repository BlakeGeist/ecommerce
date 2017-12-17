module AdminHelper
  def is_active_produt(product_id)
    unless @active_products and @active_products.include? product_id
      return 'is-active'
    end
  end
end
