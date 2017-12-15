class SitesController < ApplicationController
  skip_before_action :set_site, only: [:create]
  def index
    @sites = Site.all

    @site = Site.new

    respond_to do |format|
      format.js
      format.html
    end
   end

   def show
     @products = Product.where(id: @site.site_products.map(&:product_id))
     @category = Category.new
     @categories = Category.order(:name).paginate(:page => params[:page], :per_page => 10)
     @brands = Brand.first(5)

     @paginated = params[:page]

     if @paginated

       @products = Product.joins(:product_details).where(product_details: {name: 'active'}).where(product_details: {value: '1'}).order(:name).paginate(:page => params[:page], :per_page => 30)

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
