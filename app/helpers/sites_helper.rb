module SitesHelper
  def site_link(site)
    return root_url + site.slug + '/'
  end
  def product_link(site, product)
    return root_url + site.slug + product_path(product)
  end
  def site_by_id(site_id)
    return Site.find(site_id);
  end
end
