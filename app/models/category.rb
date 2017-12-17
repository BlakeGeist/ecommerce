class Category < ActiveRecord::Base
  has_many :category_products
  extend FriendlyId
  friendly_id :name, use: :slugged
end
