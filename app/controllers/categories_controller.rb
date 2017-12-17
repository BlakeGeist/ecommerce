class CategoriesController < ApplicationController
  include ProductsHelper

  def index
    @site = Site.find_by(name: request.domain)
    @categories = Category.where(id: @site.site_categories.map(&:category_id))
    @brands = Brand.where(id: @site.site_brands.map(&:brand_id)).first(10)
    respond_to do |format|
      format.js
      format.html
    end
   end

   def show
     @site = Site.find_by(name: request.domain)
     @category = Category.friendly.find(params[:id])
     @categories = Category.where(id: @site.site_categories.map(&:category_id)).paginate(:page => params[:page], :per_page => 10)
     @brands = Brand.where(id: @site.site_brands.map(&:brand_id)).first(10)

     @title = "#{@category.name}"
     @products = Product.where(id: @site.site_products.map(&:product_id)).where(product_categories: {category_id: @category.id}).joins(:product_categories).uniq.paginate(:page => params[:page], :per_page => 10)
   end

   def create
     @category = Category.new(category_params)

     if @category.save
       redirect_to @category
     else
       render 'new'
     end
   end

   def destroy
     @category = Category.find(params[:id])
     @category.destroy
     redirect_to :back
   end

   def send_category_to_site
     @site = Site.find(params[:site_id])
     @site.site_categories.find_or_create_by!(category_id: params[:category_id])
    render :nothing => true
   end

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end

end
