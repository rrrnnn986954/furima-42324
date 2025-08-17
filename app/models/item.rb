class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :situation
  belongs_to :shipping_charge
  belongs_to :shipping_area
  belongs_to :delivery_time

  has_one_attached :image

  validates :item_name, presence: { message: 'を入力してください' }
  validates :item_explanation, presence: { message: 'を入力してください' }

  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :situation_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_charge_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_area_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :delivery_time_id, numericality: { other_than: 1, message: 'を選択してください' }

  validates :amount, presence: { message: 'を入力してください' },
                     numericality: { only_integer: true, message: 'は数値で入力してください' },
                     inclusion: { in: 300..9_999_999, message: 'は300以上9999999以下の値にしてください' }

  validates :image, presence: { message: 'を選択してください' }

  def sold_out?
    # ここでは例えば売上済みかどうかを判定
    # 今は単純にfalseでOK
    false
  end
end
