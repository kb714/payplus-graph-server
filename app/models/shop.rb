class Shop < ApplicationRecord

  # validations
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :user_id
  validates :description, presence: true
  validates :url, presence: true
end
