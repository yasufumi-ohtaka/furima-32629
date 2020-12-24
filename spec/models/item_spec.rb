require 'rails_helper'
RSpec.describe Item, type: :model do
  before do

    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品の出品ができる場合' do
     it '必要な情報を適切に入力すると、商品の出品ができる' do
      expect(@item).to be_valid
     end
    end

    context '商品の出品ができない場合' do
     it "商品画像を1枚つけていなければ登録できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Image can't be blank"
     end

     it "商品名が空では登録できない" do
      @item.name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Name can't be blank"
     end

     it "商品の説明が空では登録できない" do
      @item.info = ""
      @item.valid?
      expect(@item.errors.full_messages).to include "Info can't be blank"
     end

     it "カテゴリーの情報が選択されていなければ登録できない" do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Category Select"
     end

     it "商品の状態についての情報が選択されていなければ登録できない" do
      @item.sales_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Sales status Select"
     end

     it "配送料の負担についての情報が選択されていなければ登録できない" do
      @item.shipping_fee_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Shipping fee status Select"
     end

     it "発送元の地域についての情報が選択されていなければ登録できない" do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Prefecture Select"
     end

     it "発送までの日数についての情報が選択されていなければ登録できない" do
      @item.scheduled_delivery_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include "Scheduled delivery Select"
     end

     it "価格についての情報が空では登録できない" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include "Price can't be blank"
     end

     it "価格の範囲が、¥300~¥9,999,999の間でなければ登録できない" do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include("Price Out of setting range")
     end

     it "価格の範囲が、¥300~¥9,999,999の間でなければ登録できない" do
      @item.price = 100000000
      @item.valid?
      expect(@item.errors.full_messages).to include("Price Out of setting range")
     end

     it "販売価格が半角数字でなければ登録できないこと" do
      @item.price = "１０００００"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price Half-width number")
     end

     it "販売価格が半角英数混合では登録できないこと" do
      @item.price = 'a10000'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price Half-width number")
     end

     it "販売価格が半角英語だけでは登録できないこと" do
      @item.price = 'aaaaa'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price Half-width number")
     end
    end
  end
end