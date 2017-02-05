module RatingAverage
  extend ActiveSupport::Concern
    def average_rating
        ratings.average(:score).round(3)
    end
end