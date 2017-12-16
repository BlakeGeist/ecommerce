class CreateSiteCategories < ActiveRecord::Migration
  def change
    create_table :site_categories do |t|
      t.integer :category_id
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
