class User < ActiveRecord::Base
  before_create :create_api_key
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  def create_api_key
    self.api_key = SecureRandom.urlsafe_base64 + SecureRandom.urlsafe_base64
  end
end