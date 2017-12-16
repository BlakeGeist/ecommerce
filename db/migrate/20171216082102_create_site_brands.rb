class CreateSiteBrands < ActiveRecord::Migration
  def change
    create_table :site_brands do |t|
      t.integer :brand_id
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
