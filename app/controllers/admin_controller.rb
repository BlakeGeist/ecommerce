class AdminController < ApplicationController
  before_action :auth_user, only: [:index]
  def index
    @sites = Site.order('created_at DESC')
    @site = Site.new
  end
  def login
    if current_user && current_user.is_admin
      redirect_to :controller => 'admin', :action => 'index'
    end
  end
  def auth_user
    unless current_user && current_user.is_admin
      redirect_to :controller => 'admin', :action => 'login'
    end
  end

end
