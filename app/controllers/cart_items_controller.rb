class CartItemsController < ApplicationController
  before_action :set_cart, only: [:create, :destroy, :remove_item]
  def create
    @cart.add_product(params[:product_id])
    respond_to do |format|
      format.js { render :file => "/cart_items/cart.js.erb" }
    end
  end

  def remove_item
    if @cart.remove_item(params[:product_id]) == 'true'
      respond_to do |format|
        format.js { render :file => "/cart_items/cart.js.erb" }
      end
    else
      @cart_item = CartItem.find(params[:item_id])
      @cart_item.destroy
      respond_to do |format|
        format.js { render :file => "/cart_items/cart.js.erb" }
      end
    end

  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    respond_to do |format|
      format.js
    end
  end

  private

  def set_cart_item
    @cart_item = CartItem.find(params[:id])
  end

  def cart_items_params
    params.require(:cart_item).permit(:product_id, :cart_id, :quanitity)
  end
end
