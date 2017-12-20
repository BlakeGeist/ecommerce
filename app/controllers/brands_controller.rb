class BrandsController < ApplicationController
  def index
    @site = Site.find_by(name: request.domain)
    @categories = Category.where(id: @site.site_categories.map(&:category_id)).paginate(:page => params[:page], :per_page => 10)
    @brands = Brand.where(id: @site.site_brands.map(&:brand_id)).paginate(:page => params[:page], :per_page => 48)
    respond_to do |format|
      format.js
      format.html
    end
   end

   def show
     @site = Site.find_by(name: request.domain)
     @brand = Brand.friendly.find(params[:id])
     @categories = Category.where(id: @site.site_categories.map(&:category_id)).paginate(:page => params[:page], :per_page => 10)
     @brands = Brand.where(id: @site.site_brands.map(&:brand_id)).first(10)
     @title = "#{@brand.name}"
     @products = Product.joins(:product_details).where(product_details: {name: 'brand'}).where(product_details: {value: @brand.name}).order(:name).paginate(:page => params[:page], :per_page => 48)
   end

   def create
     @brand = Brand.new(brand_params)

     if @brand.save
       redirect_to @brand
     else
       render 'new'
     end
   end

   def cat_to_brand
     category = Category.find(params[:cat_id])
     first_cat_product = Product.joins(:product_categories).where(product_categories: {category_id: params[:cat_id]}).first.product_details.where(name: 'brand')[0]['value']
     brand = Brand.create!(name: first_cat_product)
     category.destroy
     redirect_to brand_path(brand)
   end

   def send_brand_to_site
     @site = Site.find(params[:site_id])
     @site.site_brands.find_or_create_by!(brand_id: params[:brand_id])
    render :nothing => true
   end

   def destroy
     @brand = Brand.find(params[:id])
     @brand.destroy
     redirect_to :back
   end

   def update
     @brand = Brand.friendly.find(params[:id])

     if @brand.update(brand_params)
       redirect_to @brand
     end
   end

  private
    def brand_params
      params.require(:brand).permit(:name, :logo)
    end

end
