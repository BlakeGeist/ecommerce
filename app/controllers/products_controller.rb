class ProductsController < ApplicationController
  include ApplicationHelper
  protect_from_forgery except: :index

  def index
    require 'money'
    @products = Product.joins(:product_details).where(product_details: {name: 'active'}).where(product_details: {value: '1'}).order(:name).first(10)
    @category = Category.new
    @categories = Category.order(:name).paginate(:page => params[:page], :per_page => 10)
    @brands = Brand.first(5)

    @paginated = params[:page]

    if @paginated

      @products = Product.joins(:product_details).where(product_details: {name: 'active'}).where(product_details: {value: '1'}).order(:name).paginate(:page => params[:page], :per_page => 30)

    end

    respond_to do |format|
      format.js
      format.html
    end
   end

   def show
     @product = Product.friendly.find(params[:id])
     @title = "#{@product.name}"
   end

   def create
     @product = Product.new(product_params)

     if @product.save
       redirect_to @product
     else
       render 'new'
     end
   end

   def destroy
     @product = Product.find(params[:id])
     @product.destroy
     redirect_to :back
   end

   def send_product_to_site
     @site = Site.find_by(name: request.domain)
     @product = Product.find(params[:product_id])
     @site.site_products.find_or_create_by!(product_id: @product.id)
    render :nothing => true
   end

  private
    def product_params
      params.require(:product).permit(:name, :active)
    end
end
