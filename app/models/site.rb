class Site < ActiveRecord::Base
  has_many :site_details, dependent: :destroy
  has_many :site_products, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged

end
