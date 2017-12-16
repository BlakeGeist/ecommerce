class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_cart
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :provider, :uid])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :provider, :uid])
  end

  def set_cart
    @cart = Cart.find(session[:cart_id])
  rescue
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end

end
