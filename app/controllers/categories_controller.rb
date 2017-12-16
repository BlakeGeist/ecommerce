class CategoriesController < ApplicationController
  include ProductsHelper

  def index
    @site = Site.find_by(name: request.domain)

    @categories = Category.order(:name)
    respond_to do |format|
      format.js
      format.html
    end
   end

   def show
     @params = params
     @category = Category.friendly.find(params[:id])

     @title = "#{@category.name}"
     @products = Product.joins(:product_details).joins(:product_categories).where(product_details: {name: 'active'}).where(product_details: {value: '1'}).uniq.where(product_categories: {category_id: @category.id}).order(:name).uniq.paginate(:page => params[:page], :per_page => 24)
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
     @site = Site.find_by(name: request.domain)
     @category = Category.friendly.find(params[:category_id])
     @site.site_categories.find_or_create_by!(category_id: @category.id)
    render :nothing => true
   end

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end

end
