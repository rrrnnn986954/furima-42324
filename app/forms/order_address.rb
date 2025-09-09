class OrderAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :street, :building,
                :phone_number, :user_id, :item_id, :token

  # バリデーション
  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :street
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid' }
    validates :token
    validates :user_id
    validates :item_id
  end

  # validates :user_id
  # validates :item_id

  def save
    return false unless valid?

    order = Order.create(user_id: user_id, item_id: item_id)
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

  private

  def user_must_exist
    errors.add(:user_id, 'must exist') unless User.exists?(id: user_id)
  end

  def item_must_exist
    errors.add(:item_id, 'must exist') unless Item.exists?(id: item_id)
  end
end
