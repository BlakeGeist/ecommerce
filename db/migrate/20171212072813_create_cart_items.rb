class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.integer :product_id
      t.references :cart, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
