class SitesController < ApplicationController
    def index
      redirect_to root_url
    end

    def show
      if params[:id]
        @site = Site.find_by(slug: params[:id])
      else
        @site = Site.find_by(name: request.domain)
      end
      unless @site
        if params[:controller] == 'sites'
          redirect_to :controller => 'admin', :action => 'login'
        end
        return
      end
     @products = Product.where(id: @site.site_products.map(&:product_id)).first(10)
     @categories = Category.where(id: @site.site_categories.map(&:category_id)).first(10)
     @brands = Brand.where(id: @site.site_brands.map(&:brand_id)).first(10)

     @product = Product.last
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
