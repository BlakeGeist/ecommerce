class Category < ActiveRecord::Base
  has_many :category_products, dependent: :destroy
  extend FriendlyId
  friendly_id :name, use: :slugged
end
