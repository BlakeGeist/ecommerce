module AdminHelper
  def is_active_produt(product_id)
    if @active_products.include? product_id
      return 'is-active'
    end
  end
end
