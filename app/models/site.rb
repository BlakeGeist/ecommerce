class Site < ActiveRecord::Base
  has_many :site_details, dependent: :destroy
  has_many :site_products, dependent: :destroy
  has_many :site_categories, dependent: :destroy
  has_many :site_brands, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :pages, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged

end
