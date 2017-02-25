class Style < ActiveRecord::Base
  has_many :beers
  has_many :ratings, through: :beers

  include RatingAverage

  def self.top(n)
    sorted_by_rating_in_desc_order = Style.all.sort_by { |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take n
  end
end
