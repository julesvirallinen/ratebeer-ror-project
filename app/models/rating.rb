class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user   # rating kuuluu myös käyttäjään

  # @ratings = Rating.all

    def to_s 
        "#{beer.name}: #{score}"
    end

end