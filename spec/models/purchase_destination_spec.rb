require 'rails_helper'

RSpec.describe PurchaseDestination, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.build(:user)
      item = FactoryBot.build(:item, user_id: user)
      @purchase_destination = FactoryBot.build(:purchase_destination, user_id: user, item_id: item)
      sleep 0.1
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_destination).to be_valid
      end
      it 'building_nameは空でも保存できること' do
        @purchase_destination.building_name = ''
        expect(@purchase_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'post_codeが空だと保存できないこと' do
        @purchase_destination.post_code = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_destination.post_code = '1234567'
        @purchase_destination.valid?
        expect(@purchase_destination.errors[:post_code]).to include('is invalid. Include hyphen(-)')
      end
      it 'prefecture_idが---では保存できないこと' do
        @purchase_destination.prefecture_id = '1'
        @purchase_destination.valid?
        expect(@purchase_destination.errors[:prefecture_id]).to include("can't be blank")
      end
      it 'cityが空だと保存できないこと' do
        @purchase_destination.city = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @purchase_destination.address = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では保存できないこと' do
        @purchase_destination.phone_number = ''
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが半角のハイフンを含まない正しい形式でないと保存できないこと' do
        @purchase_destination.phone_number = '123-4567-8901'
        @purchase_destination.valid?
        expect(@purchase_destination.errors[:phone_number]).to include('is invalid. Not include hyphen(-)')
      end
      it 'phone_numberが半角の数字の10桁未満では保存できないこと' do
        @purchase_destination.phone_number = '12345689'
        @purchase_destination.valid?
        expect(@purchase_destination.errors[:phone_number]).to include('is invalid. Not include hyphen(-)')
      end
      it 'phone_numberが半角の数字の12桁以上では保存できないこと' do
        @purchase_destination.phone_number = '123456891234'
        @purchase_destination.valid?
        expect(@purchase_destination.errors[:phone_number]).to include('is invalid. Not include hyphen(-)')
      end
      it 'userが紐付いていないと保存できないこと' do
        @purchase_destination.user_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていないと保存できないこと' do
        @purchase_destination.item_id = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Item can't be blank")
      end
      it 'tokenが空では登録できないこと' do
        @purchase_destination.token = nil
        @purchase_destination.valid?
        expect(@purchase_destination.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
