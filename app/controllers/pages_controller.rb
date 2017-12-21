class PagesController < ApplicationController

  def index

  end

  def show

  end

  def create
    @site = Site.find_by(slug: params[:site_id])
    @page = @site.pages.create(page_params)
    if @page.save
      redirect_to :back
    else
      render 'new'
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    redirect_to :back
  end

 private
   def page_params
     params.require(:page).permit(:name, :text)
   end

end
