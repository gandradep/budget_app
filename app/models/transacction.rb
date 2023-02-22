class Transacction < ApplicationRecord
  validates :name, presence: true
  validates :amount, presence: true
  # associations
  belongs_to :author, class_name: 'User'
  has_many :categorizations, dependent: :destroy
  has_many :categories, through: :categorizations
end
