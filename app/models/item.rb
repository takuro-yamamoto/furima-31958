class Item < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition 
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :days_to_ship
  validates :name, :description, :price, presence: true
  validates :category_id, :condition_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id, numericality: { other_than: 1 } 
end
