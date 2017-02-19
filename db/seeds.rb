# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Brewery.create name:"Koff", year:1897
b2 = Brewery.create name:"Malmgard", year:2001
b3 = Brewery.create name:"Weihenstephaner", year:1042

s1 = Style.create name:"IPA", description: "Lorem ipsum dolor sit jne"
s2 = Style.create name:"Lager", description: "Lorem ipsum dolor sit jne"
s3 = Style.create name:"Weizen", description: "Lorem ipsum dolor sit jne"
s4 = Style.create name:"Porter", description: "Lorem ipsum dolor sit jne"
s5 = Style.create name:"Low alcohol", description: "Lorem ipsum dolor sit jne"


be1 = Beer.create name:"Iso 3"
be2 = Beer.create name:"Karhu"
be3 = Beer.create name:"Tuplahumala"
be4 = Beer.create name:"Huvila Pale Ale"
be5 = Beer.create name:"X Porter"
be6 = Beer.create name:"Hefeweizen"
be7 = Beer.create name:"Helles"

b1.beers << be1
b1.beers << be2
b1.beers<< be3
b2.beers << be4
b2.beers << be5
b3.beers << be6
b3.beers << be7

s1.beers << be4
s2.beers << be1
s2.beers << be2
s2.beers << be3
s2.beers << be7
s3.beers << be6
s4.beers << be5
