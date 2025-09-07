class OrderAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :street, :building, :phone_number, :user_id, :item_id

  # バリデーション
  with_options presence: true do
    validates :postal_code
    validates :prefecture_id
    validates :city
    validates :street
    validates :phone_number
  end

  # 保存メソッド
  def save
    # Order に price を渡さずに作成
    order = Order.create(user_id: user_id, item_id: item_id)

    # Address を作成（Order に紐づく）
    Address.create(
      order_id: order.id,
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      street: street,
      building: building,
      phone_number: phone_number
    )
  end
end
