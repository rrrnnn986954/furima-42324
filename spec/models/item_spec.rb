require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できるとき' do
      it '全ての項目が正しく入力されていれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '商品名が空では出品できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Item name を入力してください')
      end

      it '商品の説明が空では出品できない' do
        @item.item_explanation = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('Item explanation を入力してください')
      end

      it 'カテゴリーが未選択では出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Category を選択してください')
      end

      it '商品の状態が未選択では出品できない' do
        @item.situation_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Situation を選択してください')
      end

      it '配送料の負担が未選択では出品できない' do
        @item.shipping_charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping charge を選択してください')
      end

      it '発送元の地域が未選択では出品できない' do
        @item.shipping_area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Shipping area を選択してください')
      end

      it '発送までの日数が未選択では出品できない' do
        @item.delivery_time_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include('Delivery time を選択してください')
      end

      it '価格が空では出品できない' do
        @item.amount = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Amount を入力してください')
      end

      it '価格が300円未満では出品できない' do
        @item.amount = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Amount は300以上9999999以下の値にしてください')
      end

      it '価格が9,999,999円を超えると出品できない' do
        @item.amount = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Amount は300以上9999999以下の値にしてください')
      end

      it '価格が全角数字では出品できない' do
        @item.amount = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Amount は数値で入力してください')
      end

      it '画像がなければ出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Image を選択してください')
      end
    end
  end
end
