module CategoriesHelper

  def category_product(category)
    first_cat_product = Product.joins(:product_categories).where(product_categories: {category_id: category.id}).first
    return first_cat_product
  end

end
