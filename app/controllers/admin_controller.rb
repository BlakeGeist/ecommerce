class AdminController < ApplicationController
  before_action :auth_user, only: [:index]
  def index
    @sites = Site.order('created_at DESC')
    @site = Site.find_by(name: request.domain)
    @new_site = Site.new
    @active_products = @site.site_products.map(&:product_id) if @site
    @products = Product.joins(:product_details).where(product_details: {name: 'active'}).where(product_details: {value: '1'}).order('created_at').paginate(:page => params[:page], :per_page => 30)
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
