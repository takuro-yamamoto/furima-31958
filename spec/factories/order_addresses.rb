FactoryBot.define do
  factory :order_address do
    postal_code { '123-4567' }
    prefecture_id { 2 }
    municipality { '東京都' }
    addresses { '1-1' }
    building { '東京ハイツ' }
    phone_number { '09012345678' }
    item_id { '2' }
    user_id { '2' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
