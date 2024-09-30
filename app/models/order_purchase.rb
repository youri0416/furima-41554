class OrderPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :street_address, :building, :phone_number, :token

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :prefecture_id, numericality: { other_than: 1 }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/}
    validates :token
  end

  def save
    order = Order.create(user_id:, item_id:)
    Purchase.create(
      order_id: order.id, post_code:, prefecture_id:,
      city:, street_address:, building:, phone_number:
    )
  end
end
