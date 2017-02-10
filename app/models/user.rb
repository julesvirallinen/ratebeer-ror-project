class User < ActiveRecord::Base
  has_many :beers, through: :ratings
  has_many :ratings, dependent: :destroy
  has_many :memberships, dependent: :destroy


  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 30}

  validates :password, format: {with: /(?=.*[A-Z])(?=.*[0-9])(?=.{4,}).+/,
                                message: "Password must contain a number and big letter"}


  def favourite_beer
    return nil if ratings.empty? # palautetaan nil jos reittauksia ei ole
#   ratings.sort_by{ |r| r.score }.last.beer
    ratings.sort_by(&:score).last.beer
  end

  def favourite_style
    return nil if ratings.empty?
    ratings.first.beer.style
  end


end