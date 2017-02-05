class User < ActiveRecord::Base
  has_many :beers, through: :ratings
  has_many :ratings
  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: { minimum: 3, maximum: 30 }

  # validates :password, format: { with: /\A[a-zA-Z]+\z/,
  #                            message: "Only letters are allowed" }

end