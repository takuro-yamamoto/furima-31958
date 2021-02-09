require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    context 'ユーザー登録ができる時' do
      it '必要な情報を適切に入力すると、新規登録/ログインができる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できる' do
        @user.password = 'a23456'
        @user.password_confirmation = 'a23456'
        expect(@user).to be_valid
      end
    end
    context 'ユーザー登録ができない時' do
      it 'ニックネームがないと登録できない' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスがないと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが重複すると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含まないと登録できない' do
        @user.email = 'test.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードがないと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが5文字以下であれば登録できない' do
        @user.password = 'a2345'
        @user.password_confirmation = 'a2345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードは、半角英数字混合での入力をしない登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは、確認用のパスワードが空では登録できない' do
        @user.password = 'a23456'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードは、確認用のパスワードと一致しないと登録できない' do
        @user.password = 'a23456'
        @user.password_confirmation = '12345a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'ユーザー本名は、名字がないと登録できない' do
        @user.last_name_full = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name full can't be blank")
      end
      it 'ユーザー本名はな名前がないと登録できない' do
        @user.first_name_full = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name full can't be blank")
      end
      it 'ユーザー本名の名前は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name_full = 'aaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name full 全角文字を使用してください')
      end
      it 'ユーザー本名の名字は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name_full = 'aaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name full 全角文字を使用してください')
      end
      it 'ユーザー本名のフリガナは、名字がないと登録できない' do
        @user.last_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'ユーザー本名のフリガナはな名前がないと登録できない' do
        @user.first_name_kana = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'ユーザー本名のフリガナの名前は、全角（カタカナ）で入力しないと登録できない' do
        @user.first_name_kana = '1aあ漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana 全角カナ文字を使用してください')
      end
      it 'ユーザー本名のフリガナの名字は、全角（カタカナ）で入力しないと登録できない' do
        @user.last_name_kana = 'a1あ漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana 全角カナ文字を使用してください')
      end
      it '生年月日がないと登録できない' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'パスワードは英語のみでは登録できないこと' do
        @user.password = 'abcdefg'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは全角では登録できないこと' do
        @user.password = 'あああああああああ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には英字と数字の両方を含めて設定してください')
      end
    end
  end
end
