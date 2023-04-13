class Product < ApplicationRecord
  validates :name, :description, presence: true
  validates :price, presence: true, numericality: true
end
