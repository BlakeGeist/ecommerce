class SitesController < ApplicationController
  skip_before_action :set_site, only: [:create]
  def index
    redirect_to root_url
   end

    def show
      unless @site
      if current_user && current_user.is_admin
        redirect_to :controller => 'admin', :action => 'index'
      else
        redirect_to :controller => 'admin', :action => 'login'
      end
    end

     return
     @products = Product.where(id: @site.site_products.map(&:product_id))
     @category = Category.new
     @categories = Category.order(:name).paginate(:page => params[:page], :per_page => 10)
     @brands = Brand.first(5)

     @paginated = params[:page]

     if @paginated

       @products = Product.joins(:product_details).uniq.where(product_details: {name: 'active'}).where(product_details: {value: '1'}).order(:name).paginate(:page => params[:page], :per_page => 30)

     end
   end

   def create
     @site = Site.new(site_params)

     if @site.save
       redirect_to root_url + @site.slug
     else
       render 'new'
     end
   end

   def destroy
     @site = Site.find(params[:id])
     @site.destroy
     redirect_to :back
   end

   def update
     @site = Site.friendly.find(params[:id])
     if @site.update(site_params)
       redirect_to @site
     end
   end

  private
    def site_params
      params.require(:site).permit(:name, :logo)
    end

end
