class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :name
      t.string :slug

      t.timestamps null: false
    end
  end
end
