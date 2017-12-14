class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.string :name
      t.string :value
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
