class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable  :recoverable, :rememberable, :validatable,
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist
end
