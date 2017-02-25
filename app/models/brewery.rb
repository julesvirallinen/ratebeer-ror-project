class Brewery < ActiveRecord::Base
  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  validates :name, length: {minimum: 1}
  validates :year, numericality: {greater_than_or_equal_to: 1042,
                                  only_integer: true}
  validate :year_is_not_in_future

  scope :active, -> { where active:true }
  scope :retired, -> { where active:[nil,false] }


  include RatingAverage

  def self.top(n)
    sorted_by_rating_in_desc_order = Brewery.all.sort_by { |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take(3)
  end

  def year_is_not_in_future
    if year.present? && year > Date.today.year
      errors.add(:year, "Can't be in the future")
    end
  end


  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
  end

  def restart
    year = 2017
    puts "changed year to #{year}"
  end

end
