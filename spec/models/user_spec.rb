# spec/models/user_spec.rb

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    # 正常系テスト
    context '新規登録できるとき' do
      it '全ての項目が正しく入力されていれば登録できる' do
        user = User.new(
          nickname: 'テスト',
          email: 'test@example.com',
          password: 'password1',
          password_confirmation: 'password1',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birthday: '1990-01-01'
        )
        expect(user).to be_valid
      end
    end

    # 異常系テスト
    context '新規登録できないとき' do
      it 'emailが空では登録できない' do
        user = User.new(email: '', password: 'password', password_confirmation: 'password')
        user.valid?
        expect(user.errors[:email]).to include("can't be blank")
      end

      it 'emailが重複していると登録できない' do
        User.create!(
          nickname: 'テスト',
          email: 'duplicate@example.com',
          password: 'password1',
          password_confirmation: 'password1',
          last_name: '山田',
          first_name: '太郎',
          last_name_kana: 'ヤマダ',
          first_name_kana: 'タロウ',
          birthday: '1990-01-01'
        )
        user = User.new(
          nickname: 'テスト２',
          email: 'duplicate@example.com',
          password: 'password1',
          password_confirmation: 'password1',
          last_name: '鈴木',
          first_name: '次郎',
          last_name_kana: 'スズキ',
          first_name_kana: 'ジロウ',
          birthday: '1991-02-02'
        )
        user.valid?
        expect(user.errors[:email]).to include('has already been taken')
      end

      it 'emailに@を含まないと登録できない' do
        user = User.new(email: 'invalidemail.com', password: 'password', password_confirmation: 'password')
        user.valid?
        expect(user.errors[:email]).to include('is invalid')
      end

      it 'passwordが空だと登録できない' do
        user = User.new(password: '', password_confirmation: '')
        user.valid?
        expect(user.errors[:password]).to include("can't be blank")
      end

      it 'passwordが6文字未満だと登録できない' do
        user = User.new(password: '12345', password_confirmation: '12345')
        user.valid?
        expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
      end

      it 'passwordとpassword_confirmationが一致しないと登録できない' do
        user = User.new(password: 'password1', password_confirmation: 'password2')
        user.valid?
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end
  end
end
