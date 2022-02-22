class Item < ApplicationRecord
  has_one :purchase
  has_one_attached :image
  belongs_to :user

  validates :name, :explanation, :image,
            presence: true

  validates :category_id, :condition_id, :delivery_charge_id, :prefecture_id, :delivery_date_id,
            numericality: { other_than: 1 , message: "can't be blank" }
 
  VALID_PRICE_REGEX = /\A[0-9]+\z/.freeze
  validates :price,
    presence: true,
    format: { with: VALID_PRICE_REGEX, allow_blank: true },
    numericality: { only_integer: true, message: "は半角数字でご入力下さい", greater_than_or_equal_to: 300, message: "は300以上でご入力下さい", less_than_or_equal_to: 9_999_999, message: "は9999999以下でご入力下さい", allow_blank: true }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :prefecture
  belongs_to :delivery_date
  
end
