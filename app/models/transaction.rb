class Transaction < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true
  # associations
  belongs_to :author, class_name: 'User'
  has_many :category_transaction_records, dependent: :destroy
  has_many :categories, through: :category_transaction_records
end
