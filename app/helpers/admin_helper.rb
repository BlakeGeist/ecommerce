module AdminHelper
  def is_active_produt(product_id)
    if @active_products and @active_products.include? product_id
      return 'is-active'
    end
  end
  def admin_sites_path(site)
    return '/admin/sites/' + site.slug
  end
  def admin_brands_path(site)
    return '/admin/sites/' + site.slug + '/brands'
  end
  def admin_categories_path(site)
    return '/admin/sites/' + site.slug + '/categories'
  end
end
