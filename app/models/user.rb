class User < ActiveRecord::Base
  has_many :beers, through: :ratings
  has_many :ratings, dependent: :destroy
  has_many :confirmed_memberships, -> {where confirmed: true}, class_name: "Membership", dependent: :destroy
  has_many :unconfirmed_memberships, -> {where confirmed: [nil,false]}, class_name: "Membership", dependent: :destroy


  include RatingAverage

  has_secure_password

  validates :username, uniqueness: true,
            length: {minimum: 3, maximum: 30}

  validates :password, format: {with: /(?=.*[A-Z])(?=.*[0-9])(?=.{4,}).+/,
                                message: "Password must contain a number and big letter"}

  def self.top(n)
    most_ratings = User.all.sort_by{ |b| -(b.ratings.count||0) }
    most_ratings.take n
  end

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    favorite :style
  end

  def favorite_brewery
    favorite :brewery
  end

  def favorite(category)
    return nil if ratings.empty?

    rated = ratings.map{ |r| r.beer.send(category) }.uniq
    rated.sort_by { |item| -rating_of(category, item) }.first
  end

  def rating_of(category, item)
    ratings_of = ratings.select{ |r| r.beer.send(category)==item }
    ratings_of.map(&:score).inject(&:+) / ratings_of.count.to_f
  end

end
