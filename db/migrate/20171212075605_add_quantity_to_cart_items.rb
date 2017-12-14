class AddQuantityToCartItems < ActiveRecord::Migration
  def change
    add_column :cart_items, :quanitity, :integer
  end
end
