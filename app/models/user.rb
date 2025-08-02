class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 必須項目
  validates :nickname, presence: true
  validates :birthday, presence: true

  # @を含むかチェック
  validates :email, format: { with: /@/, message: 'には@を含めてください' }

  # パスワードの英数字混合チェック
  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英字と数字の両方を含めてください' }, if: -> { password.present? }

  # 全角のみ許可（ひらがな・カタカナ・漢字）
  validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }
  validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'は全角で入力してください' }

  # カタカナのみ許可
  validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
  validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, message: 'は全角カタカナで入力してください' }
end
