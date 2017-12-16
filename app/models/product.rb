class Product < ActiveRecord::Base
  has_many :product_details, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged
end
