class AddSiteIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :site_id, :integer
  end
end
