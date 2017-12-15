class CreateSiteProducts < ActiveRecord::Migration
  def change
    create_table :site_products do |t|
      t.integer :product_id
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
