class Item < ApplicationRecord
  validates :item_name,            presence: true
  validates :item_description,     presence: true
  validates :category_id,          numericality: { other_than: 1 }
  validates :condition_id,         numericality: { other_than: 1 }
  validates :shipping_fee_id,      numericality: { other_than: 1 }
  validates :prefecture_id,        numericality: { other_than: 1 }
  validates :shipping_day_id,      numericality: { other_than: 1 }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
  validates :image, presence: true

  belongs_to :user
  has_one_attached :image
end
