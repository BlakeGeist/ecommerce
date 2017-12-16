class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy

  def add_product(product_id)
    cart_item = self.cart_items.find_or_create_by!(
      product_id: product_id
    )
    if cart_item.quanitity
      cart_item.quanitity = cart_item.quanitity.to_i + 1
    else
      cart_item.quanitity = 1
    end
    cart_item.save
  end

  def remove_item(product_id)
    cart_item = self.cart_items.find_by!(
      product_id: product_id
    )
    if cart_item.quanitity > 1
      cart_item.quanitity = cart_item.quanitity.to_i - 1
      cart_item.save
      return 'true'
    end
    return 'false'
  end
end
