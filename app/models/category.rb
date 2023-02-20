class Category < ApplicationRecord
  validates :name, presence: true
  validates :icon_url, presence: true
  # associations
  belongs_to :author, class_name: 'User'
  has_many :category_transaction_records, dependent: :destroy
  has_many :transactions, through: :category_transaction_records
end
