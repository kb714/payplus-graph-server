class Shop < ApplicationRecord
  belongs_to :user, optional: true
  mount_base64_uploader :image, ShopImageUploader
  # validations
  validates :name, presence: true, exclusion: { in: %w(super-avance seguridad configuracion),
                                                 message: "El nombre %{value} no se puede utilizar." }
  validates_uniqueness_of :name, scope: :user_id
  validates :description, presence: true
  validates :url, presence: true, format: {
      with: /\A(http|https):\/\/[a-z0-9]+([\-.][a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\z/ix,
      message: 'El formato de URL es inálido, añada http o https'
  }
end
