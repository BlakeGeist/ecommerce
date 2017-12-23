class SiteDetailsController < ApplicationController
  def create

    @site = Site.find_by(slug: params[:site_id])

    @detail = @site.site_details.find_or_create_by(name: params[:site_detail][:name], value: params[:site_detail][:value])

    if @detail.save
      redirect_to :back
    else
      redirect_to root_url
    end

  end

  def update

    @site = Site.find_by(slug: params[:site_id])

    puts params

    detail = @site.site_details.find(params[:id]);

    detail.update(site_detail_params)

    redirect_to :back

  end

  private
    def site_detail_params
      params.require(:site_detail).permit(:name, :value)
    end
end
