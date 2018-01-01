class AddEbayCountsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :ebay_count, :integer
    add_column :products, :comp_ebay_count, :integer
  end
end
