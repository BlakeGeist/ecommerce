class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = params[:amount]
    @products = params[:product_id]

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    if charge.save
      @site = Site.find_by(name: request.domain)
      transaction = Transaction.create(
        :email => params[:stripeEmail],
        :source  => params[:stripeToken],
        :customer    => customer.id,
        :amount      => @amount,
        :description => 'Rails Stripe customer',
        :currency    => 'usd',
        :site_id    => @site.id,
        :product_ids => @products
      )
      if transaction.save
        @cart.destroy
        redirect_to transaction_path(transaction)
      end

    end


  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
