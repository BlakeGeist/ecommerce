class SitesController < ApplicationController
    def index
      redirect_to root_url
    end

    def show
      @site = Site.find_by(name: request.domain)
      unless @site
        if params[:controller] == 'sites'
          redirect_to :controller => 'admin', :action => 'login'
        end
        return
      end
     @products = Product.where(id: @site.site_products.map(&:product_id)).first(10)
     @category = Category.new
     @categories = Category.order(:name).paginate(:page => params[:page], :per_page => 10)
     @brands = Brand.first(5)
     @paginated = params[:page]
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
