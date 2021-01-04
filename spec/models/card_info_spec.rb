require 'rails_helper'

RSpec.describe CardInfo, type: :model do
  before do
    @user = FactoryBot.create(:user) 
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:card_info, item_id: @item.id, user_id: @user.id)
    sleep(1)
  end

  describe '商品購入機能' do
    context '購入のための情報が保存できる場合' do
      it "適切に入力された必要な情報と、tokenがあれば保存ができること" do
        expect(@order).to be_valid
      end

      it "建物名が空でも保存できる" do
        @order.building = ""
        expect(@order).to be_valid
      end
    end

    context '購入のための情報が保存できない場合' do
      it "user_idとitem_idが無い状態では保存できない" do
        @order.user_id = nil
        @order.item_id = nil
        @order.valid?
        expect(@order.errors.full_messages).to include "Item can't be blank", "User can't be blank"
      end

      it "配送先の郵便番号についての情報が空では保存できない" do
        @order.postal_code = ""
        @order.valid?
        expect(@order.errors.full_messages).to include "Postal code can't be blank"
      end

      it "配送先の郵便番号についての情報にハイフンが含まれていなければ保存できない" do
        @order.postal_code = "1111111"
        @order.valid?
        expect(@order.errors.full_messages).to include "Postal code Input correctly"
      end

      it "配送先の郵便番号についての情報は半角数字でなければ保存できない" do
        @order.postal_code = "１１１-１１１１"
        @order.valid?
        expect(@order.errors.full_messages).to include "Postal code Input correctly"
      end

      it "配送先の郵便番号に含まれるハイフンは半角でなければ保存できない" do
        @order.postal_code = "111ー1111"
        @order.valid?
        expect(@order.errors.full_messages).to include "Postal code Input correctly"
      end

      it "配送先の都道府県についての情報が選択されていなければ保存できない" do
        @order.prefecture_id = 1
        @order.valid?
        expect(@order.errors.full_messages).to include "Prefecture Select"
      end

      it "配送先の市区町村についての情報が空では保存できない" do
        @order.city = ""
        @order.valid?
        expect(@order.errors.full_messages).to include "City can't be blank"
      end

      it "配送先の番地についての情報が空では保存できない" do
        @order.addresses = ""
        @order.valid?
        expect(@order.errors.full_messages).to include "Addresses can't be blank"
      end

      it "配送先の電話番号についての情報が空では保存できない" do
        @order.phone_number = ""
        @order.valid?
        expect(@order.errors.full_messages).to include "Phone number can't be blank"
      end

      it "配送先の電話番号が半角数字でなければ登録できないこと" do
        @order.phone_number = "１０００００"
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number Input only number")
      end

      it "配送先の電話番号が半角英数混合では登録できないこと" do
        @order.phone_number = 'a10000'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number Input only number")
      end

      it "配送先の電話番号が半角英語だけでは登録できないこと" do
        @order.phone_number = 'aaaaa'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number Input only number")
      end

      it "配送先の電話番号に半角記号が含まれていては登録できないこと" do
        @order.phone_number = '000-1111-2222'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number Input only number")
      end

      it "配送先の電話番号は11文字以内でなければ登録できないこと" do
        @order.phone_number = '000000000000'
        @order.valid?
        expect(@order.errors.full_messages).to include("Phone number Input 11 digits or less")
      end

      it "tokenが空では登録できないこと" do
        @order.token = nil
        @order.valid?
        expect(@order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end