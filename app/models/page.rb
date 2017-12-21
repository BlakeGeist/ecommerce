class Page < ActiveRecord::Base
  belongs_to :site
  extend FriendlyId
  friendly_id :name, use: :slugged
end
