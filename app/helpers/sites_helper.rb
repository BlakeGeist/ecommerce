module SitesHelper
  def site_link(site)
    return root_url + site.slug + '/'
  end
  def product_link(site, product)
    return root_url + site.slug + product_path(product)
  end
end
