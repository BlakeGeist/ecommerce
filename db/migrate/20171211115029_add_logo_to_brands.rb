class AddLogoToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :logo, :text
  end
end
