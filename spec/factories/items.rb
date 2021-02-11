FactoryBot.define do
  factory :item do
    name { 'サンプル商品' }
    description { 'サンプル商品の説明' }
    category_id { 2 }
    condition_id { 2 }
    delivery_fee_id { 2 }
    prefecture_id { 2 }
    days_to_ship_id { 2 }
    price { 1000 }
    association :user
    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
