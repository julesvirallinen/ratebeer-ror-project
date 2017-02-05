class BeerClub < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
end
