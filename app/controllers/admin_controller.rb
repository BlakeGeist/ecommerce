class AdminController < ApplicationController
  skip_before_action :set_site
  def index
    @sites = Site.order('created_at DESC')
  end
  def login
    if current_user && current_user.is_admin
      redirect_to :controller => 'admin', :action => 'index'
    end
  end

end
