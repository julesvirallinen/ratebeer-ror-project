class User < ActiveRecord::Base
  has_many :beers, through: :ratings
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy


  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 30 }

  validates :password, format: { with: /(?=.*[A-Z])(?=.*[0-9])(?=.{4,}).+/,
                             message: "Password must contain a number and big letter" }

end