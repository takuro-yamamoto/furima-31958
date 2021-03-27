class OrderAddress
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipality, :addresses, :building, :phone_number, :item_id, :user_id, :token
  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :municipality
    validates :addresses
    validates :phone_number, format: { with: /\A[0-9]{10,11}\z/, message: "is invalid. ハイフンなし10桁or11桁" }
    validates :token
  end
  
  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, address: addresses, building: building, phone_number: phone_number, order_id: order.id)
  end
end