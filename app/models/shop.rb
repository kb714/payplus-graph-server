class Shop < ApplicationRecord
  belongs_to :user, optional: true
  # validations
  validates :name, presence: true, exclusion: { in: %w(super-avance seguridad configuracion),
                                                 message: "El nombre %{value} no se puede utilizar." }
  validates_uniqueness_of :name, scope: :user_id
  validates :description, presence: true
  validates :url, presence: true
end
