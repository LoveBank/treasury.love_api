class User < ActiveRecord::Base
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :omniauthable
  include DeviseTokenAuth::Concerns::User
  has_many :entries, dependent: :destroy

end
