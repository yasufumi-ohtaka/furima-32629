class CardInfo
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :token

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building, phone_number: phone_number, order_id: order.id)
  end

  with_options presence: true do
    validates :postal_code, :city, :addresses, :phone_number, :token
  end

  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'Input correctly' }

  validates :prefecture_id, numericality: { other_than: 1, message: 'Select' } 

  validates :phone_number, numericality: { only_integer: true, message: 'Input only number' }

  validates :phone_number, length: {maximum: 11, message: 'Input 11 digits or less'}

end


