class Shop < ApplicationRecord

  # validations
  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true
end
