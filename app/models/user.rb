class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable, :confirmable, :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :entries

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data["email"]).first
    unless user
      user = User.new(name: data["name"],
        email: data["email"],
        password: Devise.friendly_token[0, 20])
      user.skip_confirmation!
      user.save
    end
    user
  end
end
