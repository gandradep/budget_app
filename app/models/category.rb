class Category < ApplicationRecord
  validates :name, presence: true
  validates :icon_url, presence: true
  # associations
  belongs_to :author, class_name: 'User'
  has_many :categorizations, dependent: :destroy
  has_many :transacctions, through: :categorizations
end
