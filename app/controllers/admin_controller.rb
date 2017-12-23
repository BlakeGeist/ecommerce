class AdminController < ApplicationController
  before_action :auth_user, only: [:index]
  def index
    @sites = Site.order('created_at DESC')
    @site = Site.find_by(slug: params[:site])
    @new_site = Site.new
    @active_products = @site.site_products.map(&:product_id) if @site
    @search = Product.joins(:product_details).where(product_details: {name: 'active'}).where(product_details: {value: '1'}).ransack(params[:q])
    @products = @search.result(distinct: true).paginate(:page => params[:page], :per_page => 48)
    @transactions = Transaction.all.order('created_at DESC')
  end

  def products
    @site = Site.find_by(slug: params[:site])
    @search = Product.all.ransack(params[:q])
    @products = @search.result(distinct: true).paginate(:page => params[:page], :per_page => 100)
    @active_products = @site.site_products.map(&:product_id)
  end

  def brands
    @brands = Brand.order(:name)
    @site = Site.find_by(slug: params[:site])
    @site_brands = Brand.where(id: @site.site_brands.map(&:brand_id)).order(:name) if @site
  end

  def categories
    @site = Site.find_by(slug: params[:site])
    @categories = Category.order(:name)
    @site_categories = Category.where(id: @site.site_categories.map(&:category_id)).order(:name) if @site
  end

  def pages
    @site = Site.find_by(slug: params[:site])
  end

  def login
    if current_user && current_user.is_admin
      redirect_to :controller => 'admin', :action => 'index'
    end
  end
  def auth_user
    unless current_user && current_user.is_admin
      redirect_to :controller => 'admin', :action => 'login'
    end
  end

end
