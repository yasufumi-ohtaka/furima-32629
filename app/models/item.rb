class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image, :name, :info, :price
  end

  validates :price, numericality: { only_integer: true, message: 'Half-width number' }

  validates_inclusion_of :price, in: 300..9999999, message: 'Out of setting range' do
  end

  with_options numericality: { other_than: 1, message: 'Select' } do
    validates :category_id, :sales_status_id, :shipping_fee_status_id, :prefecture_id, :scheduled_delivery_id 
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery
end