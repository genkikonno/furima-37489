class PurchaseDestination
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token       

  with_options presence: true do
    validates :user_id, :item_id, :purchase_id, :city, :address, :token
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}, allow_blank: true
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "is invalid. Not include hyphen(-)"}, allow_blank: true
  end
  validates :prefecture_id, numericality: {other_than: 1, message: "can't be blank"}

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Destination.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase_id)
  end
end