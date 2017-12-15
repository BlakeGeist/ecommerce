class CreateSiteDetails < ActiveRecord::Migration
  def change
    create_table :site_details do |t|
      t.string :name
      t.text :value
      t.references :site, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
