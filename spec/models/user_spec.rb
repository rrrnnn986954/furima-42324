require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    # 正常系テスト
    context '新規登録できるとき' do
      it '全ての項目が正しく入力されていれば登録できる' do
        user = build(:user)
        expect(user).to be_valid
      end
    end

    # 異常系テスト
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        user = build(:user, nickname: '')
        user.valid?
        expect(user.errors[:nickname]).to include("can't be blank")
      end

      it 'emailが空では登録できない' do
        user = build(:user, email: '')
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'emailが重複していると登録できない' do
        create(:user, email: 'duplicate@example.com')
        user = build(:user, email: 'duplicate@example.com')
        user.valid?
        expect(user.errors[:email]).to include('has already been taken')
      end

      it 'emailに@を含まないと登録できない' do
        user = build(:user, email: 'invalidemail.com')
        user.valid?
        expect(user.errors[:email]).to include('is invalid')
      end

      it 'passwordが空だと登録できない' do
        user = build(:user, password: '', password_confirmation: '')
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'passwordが6文字未満だと登録できない' do
        user = build(:user, password: '12345', password_confirmation: '12345')
        user.valid?
        expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        user = build(:user, password: 'password1', password_confirmation: 'password2')
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end

      it 'last_nameが空では登録できない' do
        user = build(:user, last_name: '')
        user.valid?
        expect(user.errors[:last_name]).to include("can't be blank")
      end

      it 'last_nameが全角でないと登録できない' do
        user = build(:user, last_name: 'yamada')
        user.valid?
        expect(user.errors[:last_name]).to include('は全角で入力してください')
      end

      it 'first_name_kanaが空では登録できない' do
        user = build(:user, first_name_kana: '')
        user.valid?
        expect(user.errors[:first_name_kana]).to include("can't be blank")
      end

      it 'first_name_kanaがカタカナでないと登録できない（ひらがな）' do
        user = build(:user, first_name_kana: 'たろう')
        user.valid?
        expect(user.errors[:first_name_kana]).to include('は全角カタカナで入力してください')
      end

      it 'first_name_kanaがカタカナでないと登録できない（漢字）' do
        user = build(:user, first_name_kana: '太郎')
        user.valid?
        expect(user.errors[:first_name_kana]).to include('は全角カタカナで入力してください')
      end

      it 'birthdayが空では登録できない' do
        user = build(:user, birthday: nil)
        user.valid?
        expect(user.errors[:birthday]).to include("can't be blank")
      end
    end
  end
end
