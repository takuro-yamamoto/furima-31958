class Item < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :delivery_fee, :prefecture, :days_to_ship

  validates :name, :description, :price, :image, presence: true
  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id, numericality: { other_than: 1 }
  has_one_attached :image
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000 }
end
