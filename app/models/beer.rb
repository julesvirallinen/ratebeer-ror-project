class Beer < ActiveRecord::Base
  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, through: :ratings, source: :user

  include RatingAverage

  validates :name, presence: true
  validates :style_id, presence: true
  validates :brewery_id, presence: true


  def self.top(n)
    sorted_by_rating_in_desc_order = Beer.all.sort_by { |b| -(b.average_rating||0) }
    sorted_by_rating_in_desc_order.take(n)
  end

  def to_s
    "#{brewery.name}: #{name}"
  end
end
