class Site < ActiveRecord::Base
  has_many :site_details
  has_many :site_products
  extend FriendlyId
  friendly_id :name, use: :slugged

end
