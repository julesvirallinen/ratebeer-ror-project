class BeerClub < ActiveRecord::Base
  has_many :confirmed_memberships, -> {where confirmed: true}, class_name: "Membership", dependent: :destroy
  has_many :unconfirmed_memberships, -> {where confirmed: [nil,false]}, class_name: "Membership", dependent: :destroy

end
