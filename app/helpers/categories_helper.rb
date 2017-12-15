module CategoriesHelper

  def category_product(category)
    first_cat_product = Product.joins(:product_categories).where(product_categories: {category_id: category.id}).first
    return first_cat_product
  end

  def category_link(category)
    return root_url + @site.slug + category_path(category)
  end

  def categories_site_link
    return root_url + @site.slug + categories_path
  end

end
