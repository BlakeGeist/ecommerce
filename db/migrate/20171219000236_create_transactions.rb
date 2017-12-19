class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.text :product_ids
      t.integer :amount
      t.boolean :status
      t.string :email
      t.string :source
      t.integer :customer
      t.text :description
      t.string :currency

      t.timestamps null: false
    end
  end
end
