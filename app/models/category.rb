class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :icon, presence: true, length: { maximum: 20 }
end
