require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @user = FactoryBot.build(:user)
    @item.save
    @user.save
    sleep 1
    @order_address = FactoryBot.build(:order_address)
    @order_address.item_id=@item.id
    @order_address.user_id=@user.id
  end

  context '必要な情報を適切に入力すると、商品の購入ができること' do
    it '必要な情報を適切に入力すると、商品の購入ができること' do
      expect(@order_address).to be_valid
    end
    it '電話番号が10桁でも登録できること' do
      @order_address.phone_number = '0312345678'
      expect(@order_address).to be_valid
    end
    it '建物名が抜けていても登録できること' do
      @order_address.building = nil
      expect(@order_address).to be_valid
    end
  end
  context '正しいクレジットカードの情報で無いときは決済できないこと' do
    it 'tokenが空では登録できないこと' do
      @order_address.token = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Token can't be blank")
    end
  end
  context '配送先の情報として、郵便番号・都道府県・市区町村・番地・電話番号がないと決済できない' do
    it '郵便番号がないと決済できない' do
      @order_address.postal_code = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
    end
    it '都道府県がないと決済できない' do
      @order_address.prefecture_id = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
    end
    it '市区町村がないと決済できないこと' do
      @order_address.municipality = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Municipality can't be blank")
    end
    it '番地がないと決済できないこと' do
      @order_address.addresses = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Addresses can't be blank")
    end
    it '電話番号がないと決済できない' do
      @order_address.phone_number = nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
    end
    it '郵便番号にはハイフンが必要であること（123-4567となる）' do
      @order_address.postal_code = '1234567'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Postal code is invalid. Include hyphen(-)')
    end
    it '電話番号にはハイフンは不要で10,11桁であること（09012345678となる）' do
      @order_address.phone_number = '0901234'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include('Phone number is invalid. ハイフンなし10桁or11桁')
    end
    it '都道府県が(---)では登録できないこと' do
      @order_address.prefecture_id=1
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Prefecture must be other than 1")
    end
    it 'item_idが空では登録できないこと' do
      @order_address.item_id=nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Item can't be blank")
    end
    it 'user_idが空では登録できないこと' do
      @order_address.user_id=nil
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("User can't be blank")
    end
    it '電話番号は英数混合では保存できない' do
      @order_address.phone_number='090abcd1234'
      @order_address.valid?
      expect(@order_address.errors.full_messages).to include("Phone number is invalid. ハイフンなし10桁or11桁")
    end
  end
end
