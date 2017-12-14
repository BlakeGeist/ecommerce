class CreateProductCategories < ActiveRecord::Migration
  def change
    create_table :product_categories do |t|
      t.integer :category_id
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
