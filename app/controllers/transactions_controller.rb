class TransactionsController < ApplicationController
  require 'json'
  def show
    @transaction = Transaction.find(params[:id])
    @products = Product.where(id: JSON.parse(@transaction.product_ids))
  end

end
