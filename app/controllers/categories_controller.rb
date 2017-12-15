class CategoriesController < ApplicationController
  include ProductsHelper

  def index
    @categories = Category.order(:name)
    respond_to do |format|
      format.js
      format.html
    end
   end

   def show
     @category = Category.friendly.find(params[:id])
     @title = "#{@category.name}"
     @products = Product.joins(:product_details).joins(:product_categories).where(product_details: {name: 'active'}).where(product_details: {value: '1'}).where(product_categories: {category_id: @category.id}).order(:name).uniq.paginate(:page => params[:page], :per_page => 24)
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

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end

end
