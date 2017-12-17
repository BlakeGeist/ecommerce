module ProductsHelper
  def proffit_point(price)
    price = price.to_f
    price = (price * 0.30) + (price * 0.10) + (price + 10)
    return price.ceil - 0.01
  end
  def proffit(price)
    price = price.to_f
    new_price = (price * 0.30) + (price * 0.10) + price
    return (new_price - price).floor - 0.01
  end

  def returnProduct(id)
    return Product.find_by(id: id)
  end

  def cart_price(quantity, price)
    return proffit_point(price) * quantity
  end

  def cartTotal()
    price = 0
    @cart.cart_items.each do |item|
      item_price = cart_price(item.quanitity, returnProduct(item.product_id).product_details.where(name: 'price')[0]['value'])
      price = price + item_price
    end
    return price.round(2)
  end

  def cartDiscount()
    price = 0
    @cart.cart_items.each do |item|
      item_price = item.quanitity * returnProduct(item.product_id).product_details.where(name: 'suggested_retail')[0]['value'].to_f
      price = price + item_price
    end
    return price.round(2)
  end

  def cartCount()
    count = 0
    @cart.cart_items.each do |item|
      count = item.quanitity + count
    end
    return count
  end

  def product_detail(item)
    if @product.product_details.where(name: item).as_json[0]
      return @product.product_details.where(name: item).as_json[0]['value']
    end
  end
end
