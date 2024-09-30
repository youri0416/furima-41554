require 'rails_helper'

RSpec.describe OrderPurchase, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_purchase = FactoryBot.build(:order_purchase, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入機能' do
    context '商品が購入できる場合' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@order_purchase).to be_valid
      end
      it 'buildingは空でも購入できる' do
        @order_purchase.building = ''
        expect(@order_purchase).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'userが紐付いていないと購入できない' do
        @order_purchase.user_id = nil
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと購入できない' do
        @order_purchase.item_id = nil
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("Item can't be blank")
      end
      it 'post_codeが空だと購入できない' do
        @order_purchase.post_code = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが「3桁-4桁」の形式以外だと購入できない（不正なハイフン位置）' do
        @order_purchase.post_code = '1234-567'
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include('Post code is invalid')
      end
      it 'post_codeが「3桁-4桁」の形式以外だと購入できない（ハイフンなし）' do
        @order_purchase.post_code = '1234567'
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include('Post code is invalid')
      end
      it 'post_codeに全角数字が含まれると購入できない' do
        @order_purchase.post_code = '１２３-４５６７'
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include('Post code is invalid')
      end
      it 'post_codeに数字以外が含まれると購入できない' do
        @order_purchase.post_code = '@12-3456'
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include('Post code is invalid')
      end
      it 'prefecture_idが1では購入できない' do
        @order_purchase.prefecture_id = 1
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it 'cityが空だと購入できない' do
        @order_purchase.city = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("City can't be blank")
      end
      it 'street_addressが空だと購入できない' do
        @order_purchase.street_address = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("Street address can't be blank")
      end
      it 'phone_numberが空だと購入できない' do
        @order_purchase.phone_number = ''
        @order_purchase.valid?
        expect(@order_purchase.errors.full_messages).to include("Phone number can't be blank")
      end
    end
  end
end
