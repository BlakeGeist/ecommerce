module CategoriesHelper

  def category_product(category)
    first_cat_product = Product.where(id: @site.site_products.map(&:product_id)).where(product_categories: {category_id: category.id}).joins(:product_categories).uniq.first
    return first_cat_product
  end

  def category_link(category)
    return root_url + @site.slug + category_path(category)
  end

  def categories_site_link
    return root_url + @site.slug + categories_path
  end

end
