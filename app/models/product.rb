class Product < ActiveRecord::Base
  has_many :product_details
  has_many :product_categories
  extend FriendlyId
  friendly_id :name, use: :slugged
end
