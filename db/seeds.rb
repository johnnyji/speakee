# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

(1..100).each do |i|
  Confession.create!(title: "Yolo #{i}", school_id: 1, user_id: 1, body: %{
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Culpa amet provident a debitis quam, voluptas expedita minima impedit soluta, odio excepturi reprehenderit blanditiis asperiores aliquid officiis eligendi mollitia natus in!
    })
end