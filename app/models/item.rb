class Item < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, :condition, :delivery_fee, :prefecture, :days_to_ship

  with_options presence: true do
    validates :name
    validates :description
    validates :price
    validates :image
    with_options numericality: { other_than: 1 } do
      validates :category_id
      validates :condition_id
      validates :delivery_fee_id
      validates :prefecture_id
      validates :days_to_ship_id
    end
  end
  has_one_attached :image
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than: 10_000_000 }
end
