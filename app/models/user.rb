class User < ActiveRecord::Base
  has_many :beers, through: :ratings
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy


  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 30 }

  # validates :password, format: { with: /\d+\z/,
  #                            message: "Password must contain a number" }

end